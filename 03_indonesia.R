# ----
# title       : build census database - bps
# description : this script integrates data of 'Badan Pusat Statistik' (https://www.bps.go.id)
# license     : https://creativecommons.org/licenses/by-sa/4.0/
# authors     : Steffen Ehrmann
# date        : 2024-09-23
# version     : 0.0.0
# status      : find data, update, inventarize, validate, normalize, done
# comment     : level 4 data available at province-level websites
# ----
# geography   : Indonesia
# spatial     :
# period      : 2000 - 2022
# variables   :
# - land      : wip
# - crops     : wip
# - livestock : number_heads
# - tech      : wip
# - social    : -
# sampling    : survey
# ----

thisNation <- "Indonesia"
# source(paste0(mdl0301, "src/preprocess_bps.R"))

ds <- c("bps")
gs <- c("gadm", "bps")


# 1. register dataseries ----
#
regDataseries(name = ds[1],
              description = "Badan Pusat Statistik",
              homepage = "https://www.bps.go.id",
              licence_link = "https://www.bps.go.id/website/fileMenu/law16_97_eng.pdf",
              version = "2024.07",
              notes = "metadata namely concept and methodology is downloaded from mainpage but apply for all sub-websites")


# 2. register geometries ----
#
regGeometry(al1 = !!thisNation,
            gSeries = gs[2],
            label = list(al1 = "ADM0_EN"),
            archive = "idn_adm_bps_20200401_shp.zip|idn_admbnda_adm0_bps_20200401.shp",
            archiveLink = "https://data.amerigeoss.org/ro/dataset/indonesia-central-sulawesi-administrative-boundary-polygons-levels-1-4",
            updateFrequency = "notplanned",
            downloadDate = ymd("2022-03-14"),
            overwrite = TRUE)

regGeometry(al1 = !!thisNation,
            gSeries = gs[2],
            label = list(al1 = "ADM0_EN", al2 = "ADM1_EN"),
            archive = "idn_adm_bps_20200401_shp.zip|idn_admbnda_adm1_bps_20200401.shp",
            archiveLink = "https://data.amerigeoss.org/ro/dataset/indonesia-central-sulawesi-administrative-boundary-polygons-levels-1-4",
            updateFrequency = "notplanned",
            downloadDate = ymd("2022-03-14"),
            overwrite = TRUE)

regGeometry(al1 = !!thisNation,
            gSeries = gs[2],
            label = list(al1 = "ADM0_EN", al2 = "ADM1_EN", al3 = "ADM2_EN"),
            archive = "idn_adm_bps_20200401_shp.zip|idn_admbnda_adm2_bps_20200401.shp",
            archiveLink = "https://data.amerigeoss.org/ro/dataset/indonesia-central-sulawesi-administrative-boundary-polygons-levels-1-4",
            updateFrequency = "notplanned",
            downloadDate = ymd("2022-03-14"),
            overwrite = TRUE)

# regGeometry(al1 = !!thisNation,
#             gSeries = gs[2],
#             label = list(al1 = "ADM0_EN", al2 = "ADM1_EN", al3 = "ADM2_EN", al4 = "ADM3_EN"),
#             archive = "idn_adm_bps_20200401_shp.zip|idn_admbnda_adm3_bps_20200401.shp",
#             archiveLink = "https://data.amerigeoss.org/ro/dataset/indonesia-central-sulawesi-administrative-boundary-polygons-levels-1-4",
#             updateFrequency = "notplanned",
#             downloadDate = ymd("2022-03-14"),
#             overwrite = TRUE)

normGeometry(pattern = gs[2],
             beep = 10)


# 3. register census tables ----
#
if(build_crops){
  ## crops ----

  # work in progress
}

if(build_livestock){
  ## livestock ----

  schema_livestock_bps_al2 <-
    setFormat(na_values = "-", decimal = ",") %>%
    setFilter(rows = 1, invert = TRUE) |>
    setIDVar(name = "al2", columns = 1) %>%
    setIDVar(name = "year", columns = .find(fun = is.numeric, row = 2), rows = 2) %>%
    setIDVar(name = "method", value = "survey") %>%
    setIDVar(name = "animal", columns = 2, rows = 1, distinct = TRUE)  %>%
    setObsVar(name = "number_heads", columns = .find(fun = is.numeric, row = 2), top = 3)

  regTable(al1 = !!thisNation,
           label = "al2",
           subset = "buffalo",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_livestock_bps_al2,
           begin = 2000,
           end = 2022,
           archive = "buffalo_headcount_province_2000-2022.csv",
           archiveLink = "https://www.bps.go.id/en/statistics-table/2/NDcxIzI=/buffalo-population-by-province--heads-.html",
           downloadDate = ymd("2024-07-26"),
           updateFrequency = "annual",
           metadataLink = "https://www.bps.go.id/en/statistics-table?subject=557",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "al2",
           subset = "cattleBeef",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_livestock_bps_al2,
           begin = 2000,
           end = 2022,
           archive = "cattle_beef_headcount_province_2000-2022.csv",
           archiveLink = "https://www.bps.go.id/en/statistics-table/2/NDY5IzI=/beef-cattle-population-by-province--heads-.html",
           downloadDate = ymd("2024-07-26"),
           updateFrequency = "annual",
           metadataLink = "https://www.bps.go.id/en/statistics-table?subject=557",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "al2",
           subset = "cattleDairy",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_livestock_bps_al2,
           begin = 2000,
           end = 2022,
           archive = "cattle_dairy_headcount_province_2000-2022.csv",
           archiveLink = "https://www.bps.go.id/en/statistics-table/2/NDcwIzI=/dairy-cattle-population-by-provinsi--heads-.html",
           downloadDate = ymd("2024-07-26"),
           updateFrequency = "annual",
           metadataLink = "https://www.bps.go.id/en/statistics-table?subject=557",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "al2",
           subset = "chickenBroiler",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_livestock_bps_al2,
           begin = 2000,
           end = 2022,
           archive = "chicken_broiler_headcount_province_2000-2022.csv",
           archiveLink = "https://www.bps.go.id/en/statistics-table/2/NDc4IzI=/broiler-population-by-province--heads-.html",
           downloadDate = ymd("2024-07-26"),
           updateFrequency = "annual",
           metadataLink = "https://www.bps.go.id/en/statistics-table?subject=557",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "al2",
           subset = "chickenLayer",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_livestock_bps_al2,
           begin = 2000,
           end = 2022,
           archive = "chicken_layer_headcount_province_2000-2022.csv",
           archiveLink = "https://www.bps.go.id/en/statistics-table/2/NDc2IzI=/native-chicken-population-by-province--heads-.html",
           downloadDate = ymd("2024-07-26"),
           updateFrequency = "annual",
           metadataLink = "https://www.bps.go.id/en/statistics-table?subject=557",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "al2",
           subset = "chickenNative",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_livestock_bps_al2,
           begin = 2000,
           end = 2022,
           archive = "chicken_native_headcount_province_2000-2022.csv",
           archiveLink = "https://www.bps.go.id/en/statistics-table/2/NDc2IzI=/native-chicken-population-by-province--heads-.html",
           downloadDate = ymd("2024-07-26"),
           updateFrequency = "annual",
           metadataLink = "https://www.bps.go.id/en/statistics-table?subject=557",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "al2",
           subset = "duck",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_livestock_bps_al2,
           begin = 2000,
           end = 2022,
           archive = "duck_headcount_province_2000-2022.csv",
           archiveLink = "https://www.bps.go.id/en/statistics-table/2/NDc5IzI=/duck-muscovy-duck-population-by-province--heads-.html",
           downloadDate = ymd("2024-07-26"),
           updateFrequency = "annual",
           metadataLink = "https://www.bps.go.id/en/statistics-table?subject=557",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "al2",
           subset = "goat",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_livestock_bps_al2,
           begin = 2000,
           end = 2022,
           archive = "goat_headcount_province_2000-2022.csv",
           archiveLink = "https://www.bps.go.id/en/statistics-table/2/NDcyIzI=/goat-population-by-province--heads-.html",
           downloadDate = ymd("2024-07-26"),
           updateFrequency = "annual",
           metadataLink = "https://www.bps.go.id/en/statistics-table?subject=557",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "al2",
           subset = "horse",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_livestock_bps_al2,
           begin = 2000,
           end = 2022,
           archive = "horse_headcount_province_2000-2022.csv",
           archiveLink = "https://www.bps.go.id/en/statistics-table/2/NDc1IzI=/horse-population-by-province--heads-.html",
           downloadDate = ymd("2024-07-26"),
           updateFrequency = "annual",
           metadataLink = "https://www.bps.go.id/en/statistics-table?subject=557",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "al2",
           subset = "pig",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_livestock_bps_al2,
           begin = 2000,
           end = 2022,
           archive = "pig_headcount_province_2000-2022.csv",
           archiveLink = "https://www.bps.go.id/en/statistics-table/2/NDc0IzI=/pig-population-by-province--heads-.html",
           downloadDate = ymd("2024-07-26"),
           updateFrequency = "annual",
           metadataLink = "https://www.bps.go.id/en/statistics-table?subject=557",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "al2",
           subset = "sheep",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_livestock_bps_al2,
           begin = 2000,
           end = 2022,
           archive = "sheep_headcount_province_2000-2022.csv",
           archiveLink = "https://www.bps.go.id/en/statistics-table/2/NDczIzI=/sheep-population-by-province--heads-.html",
           downloadDate = ymd("2024-07-26"),
           updateFrequency = "annual",
           metadataLink = "https://www.bps.go.id/en/statistics-table?subject=557",
           metadataPath = "unknown",
           overwrite = TRUE)

  normTable(pattern = ds[1],
            ontoMatch = "animal",
            beep = 10)

}

if(build_landuse){
  ## landuse ----

  # work in progress
}

