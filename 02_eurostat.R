# ----
# title       : build census database - eurostat, nuts
# description : this script integrates data of 'Statistical office of the European Union' (https://ec.europa.eu/eurostat/web/main/home), 'Nomenclature des unités territoriales statistiques' (https://ec.europa.eu/eurostat/web/nuts/background)
# license     : https://creativecommons.org/licenses/by-sa/4.0/
# authors     : Steffen Ehrmann
# date        : 2024-06-05
# version     : 0.8.0
# status      : work in progress
# comment     : https://ec.europa.eu/eurostat/documents/3859598/15193590/KS-GQ-22-010-EN-N.pdf
# ----
# geography   : Europe
# spatial     : Nation (NUTS0), NUTS1, NUTS2, NUTS3
# period      : 1975 - 2022
# variables   :
# - land      : wip
# - crops     : wip
# - livestock : number_heads
# - tech      : -
# - social    : -
# sampling    : survey, census
# ----

thisNation <- "Europe"
# source(paste0(mdl0301, "src/preprocess_eurostat.R"))

# flag information: https://ec.europa.eu/eurostat/data/database/information
flags <- tibble(flag = c("b", "c", "d", "e", "f", "n", "p", "r", "s", "u", "z"),
                value = c("break in time series", "confidential",
                          "definition differs, see metadata", "estimated",
                          "forecast", "not significatn", "provisional",
                          "revised", "Eurostat estimate", "low reliability",
                          "not applicable"))


# 1. dataseries ----
#
ds <- c("eurostat")
gs <- c("nuts")

regDataseries(name = ds[1],
              description = "Statistical office of the European Union",
              homepage = "https://ec.europa.eu/eurostat/web/main/home",
              version = "2023.12.12",
              licence_link = "unknown")

regDataseries(name = gs[1],
              description = "Nomenclature des unités territoriales statistiques",
              homepage = "https://ec.europa.eu/eurostat/web/nuts/background",
              version = "2021",
              licence_link = "https://ec.europa.eu/eurostat/web/gisco/geodata/reference-data/administrative-units-statistical-units/nuts")


# 2. geometries ----
#
regGeometry(gSeries = gs[1],
            label = list(al1 = "CNTR_CODE"),
            ancillary = list(name_ltn = "NAME_LATN", name_lcl = "NUTS_NAME"),
            archive = "ref-nuts-2021-01m.shp.zip|NUTS_RG_01M_2021_3035_LEVL_0.shp",
            archiveLink = "https://gisco-services.ec.europa.eu/distribution/v2/nuts/download/ref-nuts-2021-01m.shp.zip",
            downloadDate = ymd("2019-10-10"),
            updateFrequency = "unknown",
            overwrite = TRUE)

regGeometry(gSeries = gs[1],
            label = list(al1 = "CNTR_CODE", al2 = "NUTS_ID"),
            ancillary = list(name_ltn = "NAME_LATN", name_lcl = "NUTS_NAME"),
            archive = "ref-nuts-2021-01m.shp.zip|NUTS_RG_01M_2021_3035_LEVL_1.shp",
            archiveLink = "https://gisco-services.ec.europa.eu/distribution/v2/nuts/download/ref-nuts-2021-01m.shp.zip",
            downloadDate = ymd("2019-10-10"),
            updateFrequency = "unknown",
            overwrite = TRUE)

regGeometry(gSeries = gs[1],
            label = list(al1 = "CNTR_CODE", al3 = "NUTS_ID"),
            ancillary = list(name_ltn = "NAME_LATN", name_lcl = "NUTS_NAME"),
            archive = "ref-nuts-2021-01m.shp.zip|NUTS_RG_01M_2021_3035_LEVL_2.shp",
            archiveLink = "https://gisco-services.ec.europa.eu/distribution/v2/nuts/download/ref-nuts-2021-01m.shp.zip",
            downloadDate = ymd("2019-10-10"),
            updateFrequency = "unknown",
            overwrite = TRUE)

regGeometry(gSeries = gs[1],
            label = list(al1 = "CNTR_CODE", al4 = "NUTS_ID"),
            ancillary = list(name_ltn = "NAME_LATN", name_lcl = "NUTS_NAME"),
            archive = "ref-nuts-2021-01m.shp.zip|NUTS_RG_01M_2021_3035_LEVL_3.shp",
            archiveLink = "https://gisco-services.ec.europa.eu/distribution/v2/nuts/download/ref-nuts-2021-01m.shp.zip",
            downloadDate = ymd("2019-10-10"),
            updateFrequency = "unknown",
            overwrite = TRUE)

normGeometry(pattern = gs[1],
             # query = "where CNTR_CODE = 'DK'",
             beep = 10)


# 3. tables ----
#
schema_eurostat <-
  setFormat(na_values = ":", flags = flags, decimal = ".") %>%
  setIDVar(name = "year", columns = .find(fun = is.numeric, row = 1), rows = 1)

schema_al1 <- schema_eurostat %>%
  setIDVar(name = "al1", columns = .find(pattern = "^geo", row = 1))

schema_al2 <- schema_eurostat %>%
  setIDVar(name = "al1", columns = .find(pattern = "^geo$", row = 1), split = "(.{2})") %>%
  setIDVar(name = "al2", columns = .find(pattern = "^geo", row = 1), split = "(.{3})")

schema_al3 <- schema_eurostat %>%
  setIDVar(name = "al1", columns = .find(pattern = "^geo$", row = 1), split = "(.{2})") %>%
  setIDVar(name = "al2", columns = .find(pattern = "^geo$", row = 1), split = "(.{3})") %>%
  setIDVar(name = "al3", columns = .find(pattern = "^geo", row = 1))

if(build_crops){
  ## crops ----

  # work in progress
}

if(build_livestock){
  ## livestock ----

  ### Animal populations (agr_r_animal) ----
  schema_agrranimal <- schema_al3 %>%
    setIDVar(name = "method", value = "survey") %>%
    setIDVar(name = "animal", columns = 2) %>%
    setObsVar(name = "number_heads", factor = 1000, columns = .find(fun = is.numeric, row = 1))

  regTable(un_region = thisNation,
           label = "al3",
           subset = "agrranimal",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_agrranimal,
           begin = 1977,
           end = 2023,
           archive = "agr_r_animal.tsv.gz",
           archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/agr_r_animal/",
           updateFrequency = "annually",
           downloadDate = ymd("2024-07-29"),
           metadataLink = "https://ec.europa.eu/eurostat/cache/metadata/en/apro_anip_esms.htm",
           metadataPath = "unknown",
           overwrite = TRUE)

  # as some nations don't have recent data at level 3 (looking at you, Germany!), also read in level 2 data
  schema_agrranimal2 <- schema_al2 %>%
    setIDVar(name = "method", value = "survey") %>%
    setIDVar(name = "animal", columns = 2) %>%
    setObsVar(name = "number_heads", factor = 1000, columns = .find(fun = is.numeric, row = 1))

  regTable(un_region = thisNation,
           label = "al2",
           subset = "agrranimal",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_agrranimal2,
           begin = 1977,
           end = 2023,
           archive = "agr_r_animal.tsv.gz",
           archiveLink = "https://ec.europa.eu/eurostat/databrowser/view/agr_r_animal/",
           updateFrequency = "annually",
           downloadDate = ymd("2024-07-29"),
           metadataLink = "https://ec.europa.eu/eurostat/cache/metadata/en/apro_anip_esms.htm",
           metadataPath = "unknown",
           overwrite = TRUE)

  # ignore files for some southern and eastern neighbours because they are also covered by FAOstat
  # - ENP-South Livestock: https://ec.europa.eu/eurostat/databrowser/view/enps_apro_mt_ls/
  # - ENP-South Livestock - historical data: https://ec.europa.eu/eurostat/databrowser/view/med_ag33/
  # - ENP-South Poultry farming - historical data: https://ec.europa.eu/eurostat/databrowser/view/med_ag34/
  # - ENP-East Livestock: https://ec.europa.eu/eurostat/databrowser/view/enpe_apro_mt_ls/

  normTable(pattern = paste0("agrranimal.*", ds[1]),
            ontoMatch = "animal",
            # query = "al1 == 'DK'",
            beep = 10)
}

if(build_landuse){
  ## landuse ----

  # work in progress
}
