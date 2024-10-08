# ----
# title       : build census database - agriwanet
# description : this script integrates data of 'agriwanet' (https://doi.org/10.7802/2008)
# license     : https://creativecommons.org/licenses/by-sa/4.0/
# authors     : Steffen Ehrmann
# date        : 2024-06-05
# version     : 1.0.0
# status      : done
# comment     : -
# ----
# geography   : Central Asia
# spatial     : Nation, Oblast
# period      : 1992 - 2015
# variables   :
# - land      : -
# - crops     : hectares_harvested, tons_produced
# - livestock : number_heads
# - tech      : -
# - social    : -
# sampling    : survey
# ----

ds <- c("agriwanet")
gs <- c("gadm")

# 1. dataseries ----
#
regDataseries(name = ds[1],
              description = "Agricultural Restructuring, Water Scarcity and the Adaptation to Climate Change in Central Asia",
              homepage = "https://doi.org/10.7802/2008",
              version = "",
              licence_link = "CC BY 4.0")


# 2. geometries ----
#
# based on GADM 3.6


# 3. census tables ----
#
## crops ----
if(build_crops){

  schema_agriwanet1 <-
    setIDVar(name = "al1", columns = 1) %>%
    setIDVar(name = "al2", columns = 2) %>%
    setIDVar(name = "year", columns = 4) %>%
    setIDVar(name = "method", value = "yearbook") %>%
    setIDVar(name = "crop", columns = c(20:34), rows = 1) %>%
    setObsVar(name = "hectares_harvested", factor = 1000, columns = c(20:34),
              key = 3, value = "all farms (not applic case) (10)")

  regTable(subset = "harvested",
           label = "al2",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_agriwanet1,
           begin = 1992,
           end = 2015,
           archive = "agriwanet_data_en_V1.0.csv",
           archiveLink = "https://data.gesis.org/sharing/#!Detail/10.7802/2008",
           updateFrequency = "unknown",
           downloadDate = ymd("2019-10-10"),
           metadataLink = "https://data.gesis.org/sharing/#!Detail/10.7802/2008",
           metadataPath = "agriwanet_codebook_en.pdf",
           overwrite = TRUE)

  schema_agriwanet2 <-
    setIDVar(name = "al1", columns = 1) %>%
    setIDVar(name = "al2", columns = 2) %>%
    setIDVar(name = "year", columns = 4) %>%
    setIDVar(name = "method", value = "yearbook") %>%
    setIDVar(name = "crop", columns = c(35:49), rows = 1) %>%
    setObsVar(name = "tons_produced", factor = 1000, columns = c(35:49),
              key = 3, value = "all farms (not applic case) (10)")

  regTable(subset = "production",
           label = "al2",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_agriwanet2,
           begin = 1992,
           end = 2015,
           archive = "agriwanet_data_en_V1.0.csv",
           archiveLink = "https://data.gesis.org/sharing/#!Detail/10.7802/2008",
           updateFrequency = "unknown",
           downloadDate = ymd("2019-10-10"),
           metadataLink = "https://data.gesis.org/sharing/#!Detail/10.7802/2008",
           metadataPath = "agriwanet_codebook_en.pdf",
           overwrite = TRUE)

  normTable(pattern = ds[1],
            ontoMatch = "crop",
            beep = 10)

}

## livestock ----
if(build_livestock){

  schema_agriwanet3 <-
    setIDVar(name = "al1", columns = 1) %>%
    setIDVar(name = "al2", columns = 2) %>%
    setIDVar(name = "year", columns = 4) %>%
    setIDVar(name = "method", value = "yearbook") %>%
    setIDVar(name = "animal", columns = c(50:53), rows = 1) %>%
    setObsVar(name = "number_heads", factor = 1000, columns = c(50:53),
              key = 3, value = "all farms (not applic case) (10)")

  regTable(subset = "livestock",
           label = "al2",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_agriwanet3,
           begin = 1992,
           end = 2015,
           archive = "agriwanet_data_en_V1.0.csv",
           archiveLink = "https://data.gesis.org/sharing/#!Detail/10.7802/2008",
           updateFrequency = "unknown",
           downloadDate = ymd("2019-10-10"),
           metadataLink = "https://data.gesis.org/sharing/#!Detail/10.7802/2008",
           metadataPath = "agriwanet_codebook_en.pdf",
           overwrite = TRUE)

  normTable(pattern = paste0("livestock.*", ds[1]),
            ontoMatch = "animal",
            beep = 10)

}
