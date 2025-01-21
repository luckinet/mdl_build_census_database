# ----
# title       : build census database - ssbno
# description : this script integrates data of 'Statistics Norway' (https://www.ssb.no/en/)
# license     : https://creativecommons.org/licenses/by-sa/4.0/
# authors     : Steffen Ehrmann
# date        : 2024-09-27
# version     : 0.0.1
# status      : work in progress
# comment     : file.edit(paste0(dir_docs, "/documentation/mdl_build_census_database.md"))
# ----
# geography   : Norway
# spatial     : _INSERT
# period      : _INSERT
# variables   :
# - land      : hectares_covered
# - crops     : hectares_planted, hectares_harvested, tons_produced, kiloPerHectare_yield
# - livestock : number_heads, colonies
# - tech      : number_machines, tons_applied (fertilizer)
# - social    : _INSERT
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
# regGeometry(nation = !!thisNation,
#             gSeries = gs[1],
#             label = list(al1 = "fylkesnavn"),
#             archive = "45ce04cf-b10b-4277-a64f-2a2d14e886c1.zip|fylke.shp",
#             archiveLink = "https://kart.ssb.no/",
#             downloadDate = ymd("2024-07-22"),
#             updateFrequency = "unknown")
#
# regGeometry(nation = !!thisNation,
#             gSeries = gs[1],
#             label = list(al2 = "kommunenum"),
#             archive = "45ce04cf-b10b-4277-a64f-2a2d14e886c1.zip|kommune.shp",
#             archiveLink = "https://kart.ssb.no/",
#             downloadDate = ymd("2024-07-22"),
#             updateFrequency = "unknown")
#
# regGeometry(nation = !!thisNation,
#             gSeries = gs[1],
#             label = list(al2 = "kommunenum", al3 = "grunnkre_1"),
#             archive = "45ce04cf-b10b-4277-a64f-2a2d14e886c1.zip|grunnkrets.shp",
#             archiveLink = "https://kart.ssb.no/",
#             downloadDate = ymd("2024-07-22"),
#             updateFrequency = "unknown")
#
# normGeometry(pattern = gs[1],
#              beep = 10)


# 3. tables ----
#
if(build_crops){
  ## crops ----

  # work in progress
}

if(build_livestock){
  ## livestock ----

  schema_livestock <- setCluster() %>%
    setFormat() %>%
    setIDVar(name = "al2", ) %>%
    setIDVar(name = "al3", ) %>%
    setIDVar(name = "year", ) %>%
    setIDVar(name = "method", value = "") %>%
    setIDVar(name = "animal", )  %>%
    setObsVar(name = "number_heads", )

  regTable(al1 = !!thisNation,
           label = "al_",
           subset = _INSERT,
           dSeries = ds[],
           gSeries = gs[],
           schema = schema_livestock,
           begin = _INSERT,
           end = _INSERT,
           archive = _INSERT,
           archiveLink = _INSERT,
           downloadDate = ymd(_INSERT),
           updateFrequency = _INSERT,
           metadataLink = _INSERT,
           metadataPath = _INSERT,
           overwrite = TRUE)

  13315_20240722-222718.xlsx
  11507_20240722-204729.xlsx
  06447_20240722-204649.xlsx

  normTable(pattern = ds[],
            ontoMatch = "animal",
            beep = 10)
}

if(build_landuse){
  ## landuse ----

  schema_landuse <- setCluster() %>%
    setFormat() %>%
    setIDVar(name = "al2", ) %>%
    setIDVar(name = "al3", ) %>%
    setIDVar(name = "year", ) %>%
    setIDVar(name = "methdod", value = "") %>%
    setIDVar(name = "landuse", ) %>%
    setObsVar(name = "hectares_covered", )

  regTable(al1 = !!thisNation,
           label = "al_",
           subset = _INSERT,
           dSeries = ds[],
           gSeries = gs[],
           schema = schema_landuse,
           begin = _INSERT,
           end = _INSERT,
           archive = _INSERT,
           archiveLink = _INSERT,
           downloadDate = ymd(_INSERT),
           updateFrequency = _INSERT,
           metadataLink = _INSERT,
           metadataPath = _INSERT,
           overwrite = TRUE)

  normTable(pattern = ds[],
            ontoMatch = "landuse",
            beep = 10)
}

#### test schemas
#
myRoot <- paste0(dir_census_wip, "tables/stage2/")
myFile <- "China_al2_camelsHeadcount_1978_2020_nbs.csv"
input <- read_csv(file = paste0(myRoot, myFile),
                  col_names = FALSE,
                  col_types = cols(.default = "c"))

schema <- schema_nbs_livestock
validateSchema(schema = schema, input = input)

output <- reorganise(input = input, schema = schema)
#
# https://github.com/luckinet/tabshiftr/issues
#### delete this section after finalising script
