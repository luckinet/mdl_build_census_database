# ----
# title       : build census database - ineBo, siip
# description : this script integrates data of 'Instituto Nacional de Estadística' (https://www.ine.gob.bo/), 'Sistema integrado de información productiva' (https://siip.produccion.gob.bo/)
# license     : https://creativecommons.org/licenses/by-sa/4.0/
# authors     : Steffen Ehrmann
# date        : 2025-01-22
# version     : 0.0.3
# status      : normalize, done
# comment     : file.edit(paste0(dir_docs, "/documentation/mdl_build_census_database.md"))
# ----
# geography   : Bolivia
# spatial     : ADM0, ADM1, ADM2, ADM3
# period      : 2013 - 2023
# variables   :
# - land      : -
# - crops     : -
# - livestock : number_heads (avicola, bovino, caprino, ovino, porcino, alpaca, llama)
# - tech      : -
# - social    : -
# sampling    : survey
# ----

thisNation <- "Bolivia"
# source(paste0(mdl0301, "src/preprocess_ineBo.R"))

# 1. dataseries ----
#
ds <- c("ineBo", "siip")
gs <- c("hdx")

regDataseries(name = ds[1],
              description = "Instituto Nacional de Estadística",
              homepage = "https://www.ine.gob.bo/",
              version = "2025.01",
              licence_link = "unknown")

regDataseries(name = ds[2],
              description = "Sistema integrado de información productiva",
              homepage = "https://siip.produccion.gob.bo/repSIIP2/formulario_pecuario.php",
              version = "2025.01",
              licence_link = "unknown")


# 2. geometries ----
#
# https://data.humdata.org/dataset/cod-ab-bol
regGeometry(ADM0 = !!thisNation,
            gSeries = gs[1],
            label = list(ADM0 = "ADM0_ES"),
            archive = "bol_adm_mdrt_2013.zip|bol_admbnd_adm0_mdrt_2013_v01.shp",
            archiveLink = "https://data.humdata.org/dataset/67333305-5479-4936-a7a3-1713ec3b7398/resource/4c37f36a-9916-4ea0-acff-baab539e3a23/download/bol_adm_mdrt_2013.zip",
            downloadDate = ymd("2025-01-27"),
            updateFrequency = "unknown")

regGeometry(ADM0 = !!thisNation,
            gSeries = gs[1],
            label = list(ADM0 = "ADM0_ES", ADM1 = "ADM1_ES"),
            archive = "bol_adm_mdrt_2013.zip|bol_admbnd_adm1_mdrt_2013_v01.shp",
            archiveLink = "https://data.humdata.org/dataset/67333305-5479-4936-a7a3-1713ec3b7398/resource/4c37f36a-9916-4ea0-acff-baab539e3a23/download/bol_adm_mdrt_2013.zip",
            downloadDate = ymd("2025-01-27"),
            updateFrequency = "unknown")

regGeometry(ADM0 = !!thisNation,
            gSeries = gs[1],
            label = list(ADM0 = "ADM0_ES", ADM1 = "ADM1_ES", ADM2 = "ADM2_ES"),
            archive = "bol_adm_mdrt_2013.zip|bol_admbnd_adm2_mdrt_2013_v01.shp",
            archiveLink = "https://data.humdata.org/dataset/67333305-5479-4936-a7a3-1713ec3b7398/resource/4c37f36a-9916-4ea0-acff-baab539e3a23/download/bol_adm_mdrt_2013.zip",
            downloadDate = ymd("2025-01-27"),
            updateFrequency = "unknown")

regGeometry(ADM0 = !!thisNation,
            gSeries = gs[1],
            label = list(ADM0 = "ADM0_ES", ADM1 = "ADM1_ES", ADM2 = "ADM2_ES", ADM3 = "ADM3_ES"),
            archive = "bol_adm_mdrt_2013.zip|bol_admbnd_adm3_mdrt_2013_v01.shp",
            archiveLink = "https://data.humdata.org/dataset/67333305-5479-4936-a7a3-1713ec3b7398/resource/4c37f36a-9916-4ea0-acff-baab539e3a23/download/bol_adm_mdrt_2013.zip",
            downloadDate = ymd("2025-01-27"),
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

  allFiles <- list.files(path = paste0(.get_path("cens", "_data"), "tables/stage1/siip"))
  allFiles <- allFiles[!str_detect(allFiles, "avicola")]

  for(i in seq_along(allFiles)){

    thisFile <- allFiles[i]
    name <- str_split(thisFile, "-|_")[[1]]
    year <- as.integer(name[1])
    animal <- str_split(name[3], "[.]")[[1]][1]

    schema_livestock_ineBo <-
      setFilter(rows = .find(fun = is.numeric, col = 2)) |>
      setIDVar(name = "ADM0", value = "Bolivia") |>
      setIDVar(name = "ADM1", value = str_to_title(name[2])) %>%
      setIDVar(name = "ADM3", columns = 1) |>
      setIDVar(name = "year", value = name[1]) |>
      setIDVar(name = "method", value = "survey") |>
      setIDVar(name = "animal", value = animal) |>
      setObsVar(name = "number_heads", columns = 2)

    regTable(ADM0 = !!thisNation,
             label = "ADM3",
             subset = paste0(animal, str_to_title(name[2])),
             dSeries = ds[2],
             gSeries = gs[1],
             schema = schema_livestock_ineBo,
             begin = year,
             end = year,
             archive = thisFile,
             archiveLink = "https://siip.produccion.gob.bo/repSIIP2/formulario_pecuario.php",
             downloadDate = ymd("2024-05-22"),
             updateFrequency = "annually",
             metadataLink = "https://siip.produccion.gob.bo/repSIIP2/formulario_pecuario.php",
             metadataPath = "unknown",
             overwrite = TRUE)

  }

  normTable(pattern = ds[2],
            ontoMatch = "animal",
            beep = 10)
}

if(build_landuse){
  ## landuse ----

  # work in progress
}

#### test schemas
#
myRoot <- paste0(.get_path("cens", "_data"), "tables/stage2/")
myFile <- "Bolivia_ADM3_bovinoBeni_2013_2013_siip.csv"
input <- read_csv(file = paste0(myRoot, myFile),
                  col_names = FALSE,
                  col_types = cols(.default = "c"))

schema <- schema_livestock_ineBo

schema_test <- schema |>
  validateSchema(input = input)
input_test <- input |>
  validateInput(schema = schema_test)

ids <- schema_test |>
  getIDVars(input = input_test)

obs <- schema_test |>
  getObsVars(input = input_test)

output <- reorganise(input = input, schema = schema)


adb_visualise(territory = list(ADM0 = ""),
              concept = list(animal = "cattle"),
              variable = "number_heads",
              level = "ADM2",
              year = 2000:2020,
              animate = TRUE)
