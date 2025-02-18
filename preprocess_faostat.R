

tab <- read_csv(file = paste0(.get_path("cens", "_data"), "tables/stage1/faostat/Production_Crops_Livestock_E_All_Data_(Normalized)/Production_Crops_Livestock_E_All_Data_(Normalized).csv"),
                locale = locale(encoding = "latin1"))

animals <- tab |>
  filter(Element %in% c("Stocks"))

write_csv(x = animals,
          file = paste0(.get_path("cens", "_data"), "tables/stage2/_ADM0_livestock_1961_2022_faostat.csv"),
          na = "")

