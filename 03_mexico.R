# ----
# title       : build census database - _INESRT
# description : this script integrates data of '_INSERT' (LINK)
# license     : https://creativecommons.org/licenses/by-sa/4.0/
# authors     : Steffen Ehrmann
# date        : 2024-01-14
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

thisNation <- "Mexico"

# 1. dataseries ----
#
ds <- c("inegi", "gobmx")
gs <- c("gadm")

regDataseries(name = ds[1],
              description = "National Institute of Statistics and Geography",
              homepage = "https://en.www.inegi.org.mx/",
              version = _INSERT,
              licence_link = _INSERT)

regDataseries(name = ds[2],
              description = "Gobierno de Mexico",
              homepage = "https://www.gob.mx/siap/acciones-y-programas/produccion-pecuaria",
              version = _INSERT,
              licence_link = _INSERT)


# 2. geometries ----
#
# regGeometry(nation = !!thisNation,
#             gSeries = gs[],
#             label = list(al_ = ""),
#             archive = "|",
#             archiveLink = _INSERT,
#             downloadDate = _INSERT,
#             updateFrequency = _INSERT)
#
# normGeometry(pattern = gs[],
#              beep = 10)


# 3. tables ----
#
if(build_crops){
  ## crops ----

  schema_crops <- setCluster(id = _INSERT) |>
    setFormat(header = _INSERT, decimal = _INSERT, thousand = _INSERT,
              na_values = _INSERT) |>
    setFilter() |>
    setIDVar(name = "al2", ) |>
    setIDVar(name = "al3", ) |>
    setIDVar(name = "year", ) |>
    setIDVar(name = "method", value = "") |>
    setIDVar(name = "crop", ) |>
    setObsVar(name = "hectares_harvested", ) |>
    setObsVar(name = "tons_produced", ) |>
    setObsVar(name = "kiloPerHectare_yield", )

  regTable(al1 = !!thisNation,
           label = "al_",
           subset = _INSERT,
           dSeries = ds[],
           gSeries = gs[],
           schema = schema_crops,
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
            ontoMatch = "crop",
            beep = 10)
}

if(build_livestock){
  ## livestock ----

  schema_livestock_gobmx <-
    setFormat(header = _INSERT, decimal = _INSERT, thousand = _INSERT,
              na_values = _INSERT) |>
    setFilter() |>
    setIDVar(name = "ADM1", ) |>
    setIDVar(name = "ADM2", ) |>
    setIDVar(name = "year", ) |>
    setIDVar(name = "method", value = "") |>
    setIDVar(name = "animal", ) |>
    setObsVar(name = "number_heads", )

  regTable(al1 = !!thisNation,
           label = "ADM1",
           subset = "abeja",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_gobmx,
           begin = 2014,
           end = 2023,
           archive = "Inventario 2023 Abeja.xls",
           archiveLink = "https://nube.siap.gob.mx/poblacion_ganadera/",
           downloadDate = ymd("2025-01-14"),
           updateFrequency = "annually",
           metadataLink = "https://nube.siap.gob.mx/poblacion_ganadera/",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "ADM1",
           subset = "avesCarne",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_gobmx,
           begin = 2014,
           end = 2023,
           archive = "Inventario 2023 Ave para carne.xls",
           archiveLink = "https://nube.siap.gob.mx/poblacion_ganadera/",
           downloadDate = ymd("2025-01-14"),
           updateFrequency = "annually",
           metadataLink = "https://nube.siap.gob.mx/poblacion_ganadera/",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "ADM1",
           subset = "avesHuevo",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_gobmx,
           begin = 2014,
           end = 2023,
           archive = "Inventario 2023 Ave para huevo.xls",
           archiveLink = "https://nube.siap.gob.mx/poblacion_ganadera/",
           downloadDate = ymd("2025-01-14"),
           updateFrequency = "annually",
           metadataLink = "https://nube.siap.gob.mx/poblacion_ganadera/",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "ADM1",
           subset = "avesTotal",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_gobmx,
           begin = 2014,
           end = 2023,
           archive = "Inventario 2023 Aves carne y huevo.xls",
           archiveLink = "https://nube.siap.gob.mx/poblacion_ganadera/",
           downloadDate = ymd("2025-01-14"),
           updateFrequency = "annually",
           metadataLink = "https://nube.siap.gob.mx/poblacion_ganadera/",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "ADM1",
           subset = "bovinoCarne",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_gobmx,
           begin = 2014,
           end = 2023,
           archive = "Inventario 2023 Bovino para carne.xls",
           archiveLink = "https://nube.siap.gob.mx/poblacion_ganadera/",
           downloadDate = ymd("2025-01-14"),
           updateFrequency = "annually",
           metadataLink = "https://nube.siap.gob.mx/poblacion_ganadera/",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "ADM1",
           subset = "bovinoLeche",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_gobmx,
           begin = 2014,
           end = 2023,
           archive = "Inventario 2023 Bovino para leche.xls",
           archiveLink = "https://nube.siap.gob.mx/poblacion_ganadera/",
           downloadDate = ymd("2025-01-14"),
           updateFrequency = "annually",
           metadataLink = "https://nube.siap.gob.mx/poblacion_ganadera/",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "ADM1",
           subset = "bovinoTotal",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_gobmx,
           begin = 2014,
           end = 2023,
           archive = "Inventario 2023 Bovinos carne y leche.xls",
           archiveLink = "https://nube.siap.gob.mx/poblacion_ganadera/",
           downloadDate = ymd("2025-01-14"),
           updateFrequency = "annually",
           metadataLink = "https://nube.siap.gob.mx/poblacion_ganadera/",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "ADM1",
           subset = "caprino",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_gobmx,
           begin = 2014,
           end = 2023,
           archive = "Inventario 2023 Caprino.xls",
           archiveLink = "https://nube.siap.gob.mx/poblacion_ganadera/",
           downloadDate = ymd("2025-01-14"),
           updateFrequency = "annually",
           metadataLink = "https://nube.siap.gob.mx/poblacion_ganadera/",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "ADM1",
           subset = "guajolote",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_gobmx,
           begin = 2014,
           end = 2023,
           archive = "Inventario 2023 Guajolote.xls",
           archiveLink = "https://nube.siap.gob.mx/poblacion_ganadera/",
           downloadDate = ymd("2025-01-14"),
           updateFrequency = "annually",
           metadataLink = "https://nube.siap.gob.mx/poblacion_ganadera/",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "ADM1",
           subset = "ovino",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_gobmx,
           begin = 2014,
           end = 2023,
           archive = "Inventario 2023 Ovino.xls",
           archiveLink = "https://nube.siap.gob.mx/poblacion_ganadera/",
           downloadDate = ymd("2025-01-14"),
           updateFrequency = "annually",
           metadataLink = "https://nube.siap.gob.mx/poblacion_ganadera/",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "ADM1",
           subset = "porcino",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_gobmx,
           begin = 2014,
           end = 2023,
           archive = "Inventario 2023 Porcino.xls",
           archiveLink = "https://nube.siap.gob.mx/poblacion_ganadera/",
           downloadDate = ymd("2025-01-14"),
           updateFrequency = "annually",
           metadataLink = "https://nube.siap.gob.mx/poblacion_ganadera/",
           metadataPath = "unknown",
           overwrite = TRUE)

  normTable(pattern = ds[2],
            ontoMatch = "animal",
            beep = 10)
}

if(build_landuse){
  ## landuse ----

  schema_landuse <- setCluster(id = _INSERT) |>
    setFormat(header = _INSERT, decimal = _INSERT, thousand = _INSERT,
              na_values = _INSERT) |>
    setFilter() |>
    setIDVar(name = "ADM1", ) |>
    setIDVar(name = "ADM2", ) |>
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
