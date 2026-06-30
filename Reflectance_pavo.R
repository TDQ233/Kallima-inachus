library(pavo)

# ===============================
# Load data
# ===============================
test <- read.csv(
  'reflectance.csv',
  header = TRUE
)

names(test)[1] <- "wl"

spec_data <- as.rspec(test)

smoothed_data <- procspec(spec_data, opt = "smooth", span = 0.2)

wl <- smoothed_data$wl
WT <- smoothed_data[, 22:41]
KO <- smoothed_data[, 2:21]

mean_KO <- rowMeans(KO)
mean_WT <- rowMeans(WT)
sd_KO <- apply(KO, 1, sd)
sd_WT <- apply(WT, 1, sd)

par(mfrow = c(1, 3), mar = c(5, 4, 3, 2), tcl = -0.3)

# ===============================
# Plot 1: WT
# ===============================
plot(
  wl, mean_WT,
  type = "l",
  col = "#0072B2",
  lwd = 1.5,
  ylim = range(smoothed_data[, -1]),
  xlab = "Wavelength (nm)",
  ylab = "Reflectance (%)",
  main = "WT"
)

polygon(
  c(wl, rev(wl)),
  c(mean_WT - sd_WT, rev(mean_WT + sd_WT)),
  col = rgb(0, 0, 1, 0.2),
  border = NA
)

# ===============================
# Plot 2: KO
# ===============================
plot(
  wl, mean_KO,
  type = "l",
  col = "#D55E00",
  lwd = 1.5,
  ylim = range(smoothed_data[, -1]),
  xlab = "Wavelength (nm)",
  ylab = "Reflectance (%)",
  main = "KO"
)

polygon(
  c(wl, rev(wl)),
  c(mean_KO - sd_KO, rev(mean_KO + sd_KO)),
  col = rgb(1, 0, 0, 0.2),
  border = NA
)

# ===============================
# Plot 3: KO vs WT
# ===============================
plot(
  wl, mean_KO,
  type = "l",
  col = "#D55E00",
  lwd = 1.5,
  ylim = range(smoothed_data[, -1]),
  xlab = "Wavelength (nm)",
  ylab = "Reflectance (%)",
  main = "KO vs WT"
)

polygon(
  c(wl, rev(wl)),
  c(mean_KO - sd_KO, rev(mean_KO + sd_KO)),
  col = rgb(1, 0, 0, 0.2),
  border = NA
)

lines(wl, mean_WT, col = "#0072B2", lwd = 1.5, lty = 2)

polygon(
  c(wl, rev(wl)),
  c(mean_WT - sd_WT, rev(mean_WT + sd_WT)),
  col = rgb(0, 0, 1, 0.2),
  border = NA
)

legend(
  "topright",
  legend = c("KO", "WT"),
  col = c("#D55E00", "#0072B2"),
  lwd = 1.5,
  lty = c(1, 2),
  bty = "n"
)

# ===============================
# Reset plotting parameters
# ===============================
par(mfrow = c(1, 1), tcl = -0.5)