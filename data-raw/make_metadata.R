make_metadata <- function() {
    create_dir("./inst/extdata")
    col_names <- !file.exists("./inst/extdata/metadata.csv")
    resource_list <- dir("./uploads")
    resource_maintainer <- read.dcf("DESCRIPTION", "Maintainer")
    resource_biocVersion <- BiocManager::version()
    lapply(resource_list, get_metadata, resource_maintainer,
             resource_biocVersion) %>%
        parallel_rbind() %>%
        write_csv(., "./inst/extdata/metadata.csv", append = TRUE,
                  col_names = col_names)
}
