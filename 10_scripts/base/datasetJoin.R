library(tidyverse)
library(readr)

base_dir <- "/Users/lucashelal/life_tables_raw"
folders <- list.dirs(path = base_dir, recursive = FALSE)
folders

process_file <- function(file_path) {
    df <- read_csv(file_path)


    file_name <- basename(file_path)

    file_info <- strsplit(file_name, "_")[[1]]
    age_start <- as.numeric(file_info[2])
    age_end <- gsub("\\.csv", "", file_info[3])
    shock_type <- toupper(file_info[4])

    df <- df %>%
        mutate(
            age_start = age_start,
            age_end = as.numeric(age_end),
            shock_type = shock_type
        )

    return(df)
}

all_data_noshock <- folders %>%
    lapply(function(folder) {
        csv_files <- list.files(path = folder, pattern = "NOSHOCK.csv$", full.names = TRUE)
        lapply(csv_files, process_file) %>%
            bind_rows()
    }) %>%
    bind_rows()

print(glimpse(all_data_noshock))
write_csv(all_data_noshock, file.path(base_dir, "lifeTablesPanel_NOSHOCK.csv"))
