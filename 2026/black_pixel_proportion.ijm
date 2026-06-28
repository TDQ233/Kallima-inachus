// ================= USER SETTINGS =================
inputDir  = getDirectory("C:/Desktop/input");
outputDir = getDirectory("C:/Desktop/output");

// Minimum wing size (pixels)
minWingSize = 50000;

// ================= INITIALIZE =================
setBatchMode(true);
run("Clear Results");
roiManager("Reset");

list = getFileList(inputDir);

// ================= MAIN LOOP =================
for (i = 0; i < list.length; i++) {

    filename = list[i];
    fnameLower = filename.toLowerCase();

    // Process only image files
    if (endsWith(fnameLower, ".tif") || endsWith(fnameLower, ".jpg") || endsWith(fnameLower, ".png")) {

        print("Processing file: " + filename);

        open(inputDir + filename);
        originalTitle = getTitle();

        // ---------- Convert to 8-bit ----------
        run("8-bit");

        // ====================================================
        // STEP 1: Triangle threshold to define wing ROI
        // ====================================================
        run("Duplicate...", "title=WingMask_Triangle");
        setAutoThreshold("Triangle");
        setOption("BlackBackground", false);
        run("Convert to Mask");

        triangleWindow = getTitle();

        // Generate safe output filename (replace dots)
        nameNoExt = replace(filename, ".", "_");

        // Save Step1 mask
        saveAs("PNG", outputDir + "/Step1_TriangleMask_" + nameNoExt + ".png");

        // Keep largest object = wing
        run("Analyze Particles...", "size=" + minWingSize + "-Infinity show=Nothing add");

        // Select wing ROI for measurement
        roiManager("Select", 0);
        run("Set Measurements...", "area redirect=None decimal=3");
        roiManager("Measure");
        wingRow = nResults - 1;
        wingArea = getResult("Area", wingRow);

        // ====================================================
        // STEP 2: RenyiEntropy threshold for melanin pixels
        // ====================================================
        // Apply RenyiEntropy threshold directly on original image
        selectWindow(originalTitle);
        run("Duplicate...", "title=MelaninMask_RenyiEntropy");

        setAutoThreshold("RenyiEntropy dark");
        setOption("BlackBackground", true);
        run("Convert to Mask");

        // Save Step2 mask
        saveAs("PNG", outputDir + "/Step2_YRenyiEntropy_" + nameNoExt + ".png");

        // Count white pixels = melanin
        getHistogram(values, counts, 256);
        melaninPixels = counts[0];  // melanized pixels
        melaninFraction = melaninPixels / wingArea;

        // ====================================================
        // STEP 3: Save results
        // ====================================================
        setResult("Image", i, filename);
        setResult("Wing_area", i, wingArea);
        setResult("Melanin_pixels", i, melaninPixels);
        setResult("Melanin_fraction", i, melaninFraction);

        // ====================================================
        // CLEAN UP
        // ====================================================
        roiManager("Reset");
        close("*");
    }
}

// ================= SAVE & FINISH =================
saveAs("Results", outputDir + "black_pixel_proportion_results.csv");
setBatchMode(false);
print("✔ Batch processing finished.");
