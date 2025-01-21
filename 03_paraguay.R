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

thisNation <- "Paraguay"

# 1. dataseries ----
#
ds <- c("senacsa")
gs <- c(_INSERT)

regDataseries(name = ds[1],
              description = "Instituto Nacional de Estadística y Censos",
              homepage = "http://www.senacsa.gov.py/",
              version = _INSERT,
              licence_link = _INSERT)


# 2. geometries ----
#
regGeometry(nation = !!thisNation,
            gSeries = gs[],
            label = list(al_ = ""),
            archive = "|",
            archiveLink = _INSERT,
            downloadDate = _INSERT,
            updateFrequency = _INSERT)

normGeometry(pattern = gs[],
             beep = 10)


# 3. tables ----
#
if(build_crops){
  ## crops ----

  # work in progress
}

if(build_livestock){
  ## livestock ----

  schema_livestock <- setCluster(id = _INSERT) |>
    setFormat(header = _INSERT, decimal = _INSERT, thousand = _INSERT,
              na_values = _INSERT) |>
    setFilter() |>
    setIDVar(name = "al2", ) |>
    setIDVar(name = "al3", ) |>
    setIDVar(name = "year", ) |>
    setIDVar(name = "method", value = "") |>
    setIDVar(name = "animal", ) |>
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

  normTable(pattern = ds[],
            ontoMatch = "animal",
            beep = 10)
}

if(build_landuse){
  ## landuse ----

  schema_landuse <- setCluster(id = _INSERT) |>
    setFormat(header = _INSERT, decimal = _INSERT, thousand = _INSERT,
              na_values = _INSERT) |>
    setFilter() |>
    setIDVar(name = "al2", ) |>
    setIDVar(name = "al3", ) |>
    setIDVar(name = "year", ) |>
    setIDVar(name = "methdod", value = "") |>
    setIDVar(name = "landuse", ) |>
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
myRoot <- paste0(dir_census_data, "tables/stage2/")
myFile <- "Brazil_al3_bubalino_1990_2022_ibge.csv"
input <- read_csv(file = paste0(myRoot, myFile),
                  col_names = FALSE,
                  col_types = cols(.default = "c"))

schema <- schema_ibge2

schema <- schema |>
  validateSchema(input = input)
input <- input |>
  validateInput(schema = schema)

ids <- schema |>
  getIDVars(input = input)

obs <- schema |>
  getObsVars(input = input)

output <- reorganise(input = input, schema = schema)


adb_visualise(territory = list(al1 = "Russian Federation"),
              concept = list(animal = "cattle"),
              variable = "number_heads",
              level = "al3",
              year = 2000:2020,
              animate = TRUE)
