context("Download AND PREPARE")

test_that("GDCdownload API method for two files is working ", {
    query <- GDCquery(project = "TCGA-ACC",
                      data.category =  "Copy number variation",
                      legacy = TRUE,
                      file.type = "hg19.seg",
                      barcode = c("TCGA-OR-A5LR-01A-11D-A29H-01", "TCGA-OR-A5LJ-10A-01D-A29K-01"))
    # data will be saved in  GDCdata/TCGA-ACC/legacy/Copy_number_variation/Copy_number_segmentation
    GDCdownload(query, method = "api")
    files <- file.path("GDCdata/TCGA-ACC/legacy/",
                       gsub(" ","_",query$results[[1]]$data_category),
                       gsub(" ","_",query$results[[1]]$data_type),
                       query$results[[1]]$file_id,
                       query$results[[1]]$file_name)
    expect_true(all(file.exists(files)))
    unlink("GDCdata",recursive = TRUE, force = TRUE)
})
test_that("GDCdownload API method for one files is working ", {
    query <- GDCquery(project = "TCGA-ACC",
                      data.category =  "Copy number variation",
                      legacy = TRUE,
                      file.type = "hg19.seg",
                      barcode = c("TCGA-OR-A5LR-01A-11D-A29H-01"))
    # data will be saved in  GDCdata/TCGA-ACC/legacy/Copy_number_variation/Copy_number_segmentation
    #GDCdownload(query, method = "api", directory = "example_data_dir")
    GDCdownload(query, method = "api", directory = "ex")
    files <- file.path("ex/TCGA-ACC/legacy/",
                       gsub(" ","_",query$results[[1]]$data_category),
                       gsub(" ","_",query$results[[1]]$data_type),
                       query$results[[1]]$file_id,
                       query$results[[1]]$file_name)
    expect_true(all(file.exists(files)))
})

test_that("getBarcodeInfo works", {
    cols <- c("gender","project_id","days_to_last_follow_up","alcohol_history","cigarettes_per_day")
    x <- getBarcodeInfo(c("TCGA-OR-A5LR", "TCGA-OR-A5LJ"))
    expect_true(all(cols %in% colnames(x)))

    cols <- c("gender","project_id")
    x <- getBarcodeInfo(c("TARGET-20-PARUDL"))
    expect_true(all(cols %in% colnames(x)))

})

