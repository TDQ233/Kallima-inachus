library(ggpubr)
library(dplyr)
library(tidyr)
library(ggplot2)
library(rstatix)

# ===============================
# Load data
# ===============================
test <- read.csv(
  "reflectance.csv",
  header = TRUE
)

wl <- test[, 1]

KO <- test[, 2:21]
WT <- test[, 22:41]

# ===============================
# Combine spectra
# ===============================
spectra <- cbind(KO, WT)

group <- factor(
  c(rep("KO", ncol(KO)),
    rep("WT", ncol(WT))),
  levels = c("WT", "KO")
)

# ===============================
# Metrics
# ===============================
brightness <- colMeans(spectra)

chroma <- apply(
  spectra,
  2,
  function(x) (max(x) - min(x)) / mean(x)
)

indices <- data.frame(
  Group = group,
  Brightness = brightness,
  Chroma = chroma
)

indices_long <- indices %>%
  pivot_longer(
    cols = c("Brightness", "Chroma"),
    names_to = "Metric",
    values_to = "Value"
  )

# ===============================
# Statistics
# ===============================
stat.test <- indices_long %>%
  group_by(Metric) %>%
  wilcox_test(Value ~ Group) %>%
  adjust_pvalue(method = "BH") %>%
  add_significance("p.adj") %>%
  add_xy_position(x = "Group")

stat.test$p.adj.signif <- ifelse(
  stat.test$p.adj < 0.001, "***",
  ifelse(stat.test$p.adj < 0.01, "**",
         ifelse(stat.test$p.adj < 0.05, "*", "n.s."))
)

# ===============================
# Plot
# ===============================
p <- ggplot(indices_long, aes(x = Group, y = Value, fill = Group)) +
  
  # Boxplot
  geom_boxplot(
    width = 0.55,
    outlier.shape = NA,
    alpha = 0.6,
    color = "black",
    linewidth = 0.4
  ) +
  
  # Raw data points
  geom_jitter(
    width = 0.12,
    size = 1.6,
    alpha = 0.6,
    color = "black"
  ) +
  
  # Significance
  stat_pvalue_manual(
    stat.test,
    label = "p.adj.signif",
    tip.length = 0.01,
    bracket.size = 0.4,
    size = 5
  ) +
  
  # Facets
  facet_wrap(~Metric, scales = "free_y", nrow = 1) +
  
  # Color
  scale_fill_manual(
    values = c(
      "WT" = "#4DBBD5",
      "KO" = "#E64B35"
    )
  ) +
  
  labs(x = NULL, y = "Value") +
  
  theme_classic(base_size = 12) +
  
  theme(
    legend.position = "none",
    axis.line = element_line(linewidth = 0.4),
    axis.ticks = element_line(linewidth = 0.4),
    strip.background = element_blank(),
    strip.text = element_text(face = "bold", size = 11),
    plot.margin = margin(5, 5, 5, 5),
    axis.text = element_text(color = "black"),
    axis.title = element_text(face = "plain")
  )

print(p)