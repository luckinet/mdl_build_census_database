# ----
# title       : build census database - _INESRT
# description : this script integrates data of '_INSERT' (LINK)
# license     : https://creativecommons.org/licenses/by-sa/4.0/
# authors     : Steffen Ehrmann
# date        : 2024-MM-DD
# version     : 0.0.0
# status      : find data, update, inventarize, validate, normalize, done
# comment     : file.edit(paste0(dir_docs, "/documentation/mdl_build_census_database.md"))
# ----
# geography   : _INSERT
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

thisNation <- "Bolivia"
# source(paste0(mdl0301, "src/preprocess_ineBo.R"))

# 1. dataseries ----
#
ds <- c("ine_bo", "siip")
gs <- c("gadm")

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
myFile <- "Bolivia_ADM2_avicolaBeni_2013_2013_siip.csv"
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
