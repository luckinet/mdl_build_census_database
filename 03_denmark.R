# ----
# title       : build census database - dstdk
# description : this script integrates data of 'Statistics Denmark' (https://www.statbank.dk, https://www.statbank.dk/statbank5a)
# license     : https://creativecommons.org/licenses/by-sa/4.0/
# authors     : Steffen Ehrmann
# date        : 2024-09-27
# version     : 0.0.1
# status      : work in progress
# comment     : file.edit(paste0(dir_docs, "/documentation/mdl_build_census_database.md"))
# ----
# geography   : Denmark
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





thisNation <- "Denmark"

# 1. dataseries ----
#
ds <- c("dstdk")
gs <- c("dstdk")

regDataseries(name = ds[1],
              description = "Statistics Denmark",
              homepage = "https://www.statbank.dk",
              version = "2024.10",
              licence_link = "unknown")


# 2. geometries ----
#
regGeometry(nation = !!thisNation,
            gSeries = gs[],
            label = list(ADM_ = ""),
            archive = "|",
            archiveLink = _INSERT,
            downloadDate = _INSERT,
            updateFrequency = _INSERT)

normGeometry(pattern = gs[1],
             beep = 10)


# 3. tables ----
#
if(build_crops){
  ## crops ----
  # https://www.statbank.dk/AFG5
  # https://www.statbank.dk/AFG
  #
  # https://www.statbank.dk/HST77
  # https://www.statbank.dk/HST7
  # https://www.statbank.dk/HALM
  # https://www.statbank.dk/HALM1
  # https://www.statbank.dk/FL1

  # work in progress
}

if(build_livestock){
  ## livestock ----

  schema_livestock <- setCluster() %>%
    setFormat() %>%
    setIDVar(name = "ADM1", ) %>%
    setIDVar(name = "year", ) %>%
    setIDVar(name = "method", value = "") %>%
    setIDVar(name = "animal", )  %>%
    setObsVar(name = "number_heads", )

  regTable(al1 = !!thisNation,
           label = "ADM1",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_livestock,
           begin = 1982,
           end = 2006,
           archive = "2025116204311516975717HDYR74683155415.csv",
           archiveLink = "https://www.statbank.dk/HDYR",
           downloadDate = ymd("2025-01-16"),
           updateFrequency = "annually",
           metadataLink = "https://www.statbank.dk/statbank5a/selectvarval/Define.asp?MainTable=HDYR&TabStrip=Info&PLanguage=1&FF=8",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "ADM1",
           subset = "livestock",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_livestock,
           begin = 2006,
           end = 2023,
           archive = "2024726135823474083435HST7750306201535.csv",
           archiveLink = "https://www.statbank.dk/HDYR07",
           downloadDate = ymd("2025-01-16"),
           updateFrequency = "annually",
           metadataLink = "https://www.statbank.dk/statbank5a/selectvarval/Define.asp?MainTable=HDYR07&TabStrip=Info&PLanguage=1&FF=8",
           metadataPath = "unknown",
           overwrite = TRUE)


  normTable(pattern = ds[1],
            ontoMatch = "animal",
            beep = 10)
}

if(build_landuse){
  ## landuse ----

  schema_landuse <- setCluster() %>%
    setFormat() %>%
    setIDVar(name = "ADM1", ) %>%
    setIDVar(name = "ADM2", ) %>%
    setIDVar(name = "year", ) %>%
    setIDVar(name = "methdod", value = "") %>%
    setIDVar(name = "landuse", ) %>%
    setObsVar(name = "hectares_covered", )

  regTable(al1 = !!thisNation,
           label = "ADM_",
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
