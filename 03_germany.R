# ----
# title       : build census database - genesis
# description : this script integrates data of 'Regionaldatenbank Deutschland' (https://www.regionalstatistik.de/genesis/online)
# license     : https://creativecommons.org/licenses/by-sa/4.0/
# authors     : Steffen Ehrmann
# date        : 2024-09-27
# version     : 0.0.1
# status      : work in progress
# comment     : file.edit(paste0(dir_docs, "/documentation/mdl_build_census_database.md"))
# ----
# geography   : Germany
# spatial     : _INSERT
# period      : _INSERT
# variables   :
# - land      : hectares_covered
# - crops     : hectares_harvested, tons_produced, kiloPerHectare_yield
# - livestock : number_heads
# - tech      : number_machines, tons_applied (fertilizer)
# - social    : _INSERT
# sampling    : survey, census
# ----

thisNation <- "Germany"

# 1. dataseries ----
#
ds <- c("genesis")
gs <- c("gadm")

regDataseries(name = ds[1],
              description = "Regionaldatenbank Deutschland",
              homepage = "https://www.regionalstatistik.de/genesis/online",
              version = "2024.07",
              licence_link = "https://www.govdata.de/dl-de/by-2-0")


# 2. geometries ----
#


# 3. tables ----
#
if(build_crops){
  ## crops ----

  # work in progress
}

if(build_livestock){
  ## livestock ----

  schema_livestock_census <- setCluster() %>%
    setFormat() %>%
    setIDVar(name = "ADM1", ) %>%
    setIDVar(name = "ADM2", ) %>%
    setIDVar(name = "year", ) %>%
    setIDVar(name = "method", value = "census") %>%
    setIDVar(name = "animal", )  %>%
    setObsVar(name = "number_heads", )

  schema_livestock_survey <- setCluster() %>%
    setFormat() %>%
    setIDVar(name = "ADM1", ) %>%
    setIDVar(name = "ADM2", ) %>%
    setIDVar(name = "year", ) %>%
    setIDVar(name = "method", value = "survey") %>%
    setIDVar(name = "animal", )  %>%
    setObsVar(name = "number_heads", )

  regTable(ADM0 = !!thisNation,
           label = "ADM2",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_livestock_census,
           begin = 1999,
           end = 2007,
           archive = "41120-12-01-4.csv",
           archiveLink = "https://www.regionalstatistik.de/genesis//online?operation=table&code=41120-12-01-4",
           downloadDate = ymd("2024-07-30"),
           updateFrequency = "annually",
           metadataPath = "",
           metadataLink = "https://www.regionalstatistik.de/genesis/online?operation=statistic&levelindex=0&levelid=1722440782412&code=41312",
           overwrite = TRUE)

  regTable(ADM0 = !!thisNation,
           label = "ADM2",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_livestock_census,
           begin = 2010,
           end = 2010,
           archive = "41141-03-02-4_2010.csv",
           archiveLink = "https://www.regionalstatistik.de/genesis//online?operation=table&code=41141-03-02-4",
           downloadDate = ymd("2024-07-30"),
           updateFrequency = "annually",
           metadataPath = "",
           metadataLink = "https://www.regionalstatistik.de/genesis/online?operation=statistic&levelindex=0&levelid=1722440782412&code=41312",
           overwrite = TRUE)

  regTable(ADM0 = !!thisNation,
           label = "ADM2",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_livestock_census,
           begin = 2016,
           end = 2016,
           archive = "41141-03-02-4_2016.csv",
           archiveLink = "https://www.regionalstatistik.de/genesis//online?operation=table&code=41141-03-02-4",
           downloadDate = ymd("2024-07-30"),
           updateFrequency = "annually",
           metadataPath = "",
           metadataLink = "https://www.regionalstatistik.de/genesis/online?operation=statistic&levelindex=0&levelid=1722440782412&code=41312",
           overwrite = TRUE)

  regTable(ADM0 = !!thisNation,
           label = "ADM2",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_livestock_census,
           begin = 2020,
           end = 2020,
           archive = "41141-03-02-4_2020.csv",
           archiveLink = "https://www.regionalstatistik.de/genesis//online?operation=table&code=41141-03-02-4",
           downloadDate = ymd("2024-07-30"),
           updateFrequency = "annually",
           metadataPath = "",
           metadataLink = "https://www.regionalstatistik.de/genesis/online?operation=statistic&levelindex=0&levelid=1722440782412&code=41312",
           overwrite = TRUE)

  regTable(ADM0 = !!thisNation,
           label = "ADM2",
           subset = "cattle",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_livestock_survey,
           begin = 2009,
           end = 2023,
           archive = "41312-01-01-4.csv",
           archiveLink = "https://www.regionalstatistik.de/genesis//online?operation=table&code=41312-01-01-4",
           downloadDate = ymd("2024-07-30"),
           updateFrequency = "annuallyly",
           metadataPath = "",
           metadataLink = "https://www.regionalstatistik.de/genesis/online?operation=statistic&levelindex=0&levelid=1722440782412&code=41312",
           overwrite = TRUE)

  normTable(pattern = ds[1],
            ontoMatch = "animal",
            beep = 10)
}

if(build_landuse){
  ## landuse ----

  # work in progress
}

#### test schemas
#
# myRoot <- paste0(census_dir, "tables/stage2/")
# myFile <- ""
# input <- read_csv(file = paste0(myRoot, myFile),
#                   col_names = FALSE,
#                   col_types = cols(.default = "c"))
#
# schema <-
# validateSchema(schema = schema, input = input)
#
# output <- reorganise(input = input, schema = schema)
#
# https://github.com/luckinet/tabshiftr/issues
#### delete this section after finalising script
