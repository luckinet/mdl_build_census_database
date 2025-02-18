# ----
# title       : build census database - _INESRT
# description : this script integrates data of '_INSERT' (LINK)
# license     : https://creativecommons.org/licenses/by-sa/4.0/
# authors     : Steffen Ehrmann
# date        : YYYY-MM-DD
# version     : 0.0.0
# status      : work in progress [%], finished
# notes       : see 00_main.R
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
# comment     : _INSERT
# ----

thisNation <- _INSERT

# 1. dataseries ----
#
ds <- c(_INSERT)
gs <- c(_INSERT)

regDataseries(name = ds[],
              description = _INSERT,
              homepage = _INSERT,
              version = _INSERT,
              licence_link = _INSERT)


# 2. geometries ----
#
regGeometry(ADM0 = !!thisNation,
            gSeries = gs[],
            label = list(ADM_ = ""),
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

  schema_crops <- setCluster(id = _INSERT) |>
    setFormat(header = _INSERT, decimal = _INSERT, thousand = _INSERT,
              na_values = _INSERT) |>
    setFilter() |>
    setIDVar(name = "ADM0", ) |>
    setIDVar(name = "ADM1", ) |>
    setIDVar(name = "ADM2", ) |>
    setIDVar(name = "year", ) |>
    setIDVar(name = "method", value = "") |>
    setIDVar(name = "crop", ) |>
    setObsVar(name = "hectares_harvested", ) |>
    setObsVar(name = "tons_produced", ) |>
    setObsVar(name = "kiloPerHectare_yield", )

  regTable(al1 = !!thisNation,
           label = "ADM_",
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

  schema_livestock <- setCluster(id = _INSERT) |>
    setFormat(header = _INSERT, decimal = _INSERT, thousand = _INSERT,
              na_values = _INSERT) |>
    setFilter() |>
    setIDVar(name = "ADM0", ) |>
    setIDVar(name = "ADM1", ) |>
    setIDVar(name = "ADM2", ) |>
    setIDVar(name = "year", ) |>
    setIDVar(name = "method", value = "") |>
    setIDVar(name = "animal", ) |>
    setObsVar(name = "number_heads", )

  regTable(al1 = !!thisNation,
           label = "ADM_",
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
    setIDVar(name = "ADM0", ) |>
    setIDVar(name = "ADM1", ) |>
    setIDVar(name = "ADM2", ) |>
    setIDVar(name = "year", ) |>
    setIDVar(name = "methdod", value = "") |>
    setIDVar(name = "landuse", ) |>
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
