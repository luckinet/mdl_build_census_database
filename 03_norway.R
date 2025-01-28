# ----
# title       : build census database - ssbno
# description : this script integrates data of 'Statistics Norway' (https://www.ssb.no/en/, https://www.ssb.no/en/statbank/list/stjord)
# license     : https://creativecommons.org/licenses/by-sa/4.0/
# authors     : Steffen Ehrmann
# date        : 2025-01-22
# version     : 0.0.2
# status      : work in progress
# comment     : file.edit(paste0(dir_docs, "/documentation/mdl_build_census_database.md"))
# ----
# geography   : Norway
# spatial     : ADM1, ADM2
# period      : 1969 - 2023
# variables   :
# - land      : -
# - crops     : -
# - livestock : number_heads
# - tech      : -
# - social    : -
# sampling    : survey, census
# ----

thisNation <- "Norway"

# 1. dataseries ----
#
ds <- c("ssbno")
gs <- c("ssbno")

regDataseries(name = ds[1],
              description = "Statistics Norway",
              homepage = "https://www.ssb.no/en/",
              version = "2024.09",
              licence_link = licenses$by4)


# 2. geometries ----
#
regGeometry(ADM0 = !!thisNation,
            gSeries = gs[1],
            label = list(ADM1 = "fylkesnavn"),
            archive = "45ce04cf-b10b-4277-a64f-2a2d14e886c1.zip|fylke.shp",
            archiveLink = "https://kart.ssb.no/",
            downloadDate = ymd("2024-07-22"),
            updateFrequency = "unknown")

regGeometry(ADM0 = !!thisNation,
            gSeries = gs[1],
            label = list(ADM2 = "kommunenum"),
            archive = "45ce04cf-b10b-4277-a64f-2a2d14e886c1.zip|kommune.shp",
            archiveLink = "https://kart.ssb.no/",
            downloadDate = ymd("2024-07-22"),
            updateFrequency = "unknown")

regGeometry(ADM0 = !!thisNation,
            gSeries = gs[1],
            label = list(ADM2 = "kommunenum", ADM3 = "grunnkre_1"),
            archive = "45ce04cf-b10b-4277-a64f-2a2d14e886c1.zip|grunnkrets.shp",
            archiveLink = "https://kart.ssb.no/",
            downloadDate = ymd("2024-07-22"),
            updateFrequency = "unknown")

normGeometry(pattern = gs[1],
             beep = 10)


# 3. tables ----
#
if(build_crops){
  ## crops ----

  # work in progress
}

if(build_livestock){
  ## livestock ----

  schema_livestock_ssbno <- setCluster() %>%
    setFormat() %>%
    setIDVar(name = "ADM1", ) %>%
    setIDVar(name = "ADM2", ) %>%
    setIDVar(name = "year", ) %>%
    setIDVar(name = "method", value = "") %>%
    setIDVar(name = "animal", )  %>%
    setObsVar(name = "number_heads", )

  ### detailed species ----
  regTable(ADM0 = !!thisNation,
           label = "ADM1",
           subset = "surveySpecies",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_livestock_ssbno,
           begin = 1969,
           end = 2023,
           archive = "11507_20240722-204729.xlsx",
           archiveLink = "https://www.ssb.no/en/statbank/table/11507/tableViewLayout1/",
           downloadDate = ymd("2025-01-16"),
           updateFrequency = "annually",
           metadataLink = "https://www.ssb.no/en/statbank/table/11507",
           metadataPath = "unknown",
           overwrite = TRUE)

  ### detailed admin units ----
  regTable(ADM0 = !!thisNation,
           label = "ADM2",
           subset = "surveyAdmin",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_livestock_ssbno,
           begin = 1969,
           end = 2023,
           archive = "06447_20240722-204649.xlsx",
           archiveLink = "https://www.ssb.no/en/statbank/table/06447/tableViewLayout1/",
           downloadDate = ymd("2025-01-16"),
           updateFrequency = "annually",
           metadataLink = "https://www.ssb.no/en/statbank/table/06447",
           metadataPath = "unkown",
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
myRoot <- paste0(dir_census_wip, "tables/stage2/")
myFile <- ""
input <- read_csv(file = paste0(myRoot, myFile),
                  col_names = FALSE,
                  col_types = cols(.default = "c"))

schema <- schema_nbs_livestock
validateSchema(schema = schema, input = input)

output <- reorganise(input = input, schema = schema)
#
# https://github.com/luckinet/tabshiftr/issues
#### delete this section after finalising script
