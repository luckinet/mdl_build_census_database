# ----
# title       : build census database - _INESRT
# description : this script integrates data of '_INSERT' (LINK)
# license     : https://creativecommons.org/licenses/by-sa/4.0/
# authors     : Steffen Ehrmann
# date        : 2024-10-14
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

thisNation <- "Colombia"

# 1. dataseries ----
#
ds <- c("dane", "ica")
gs <- c("gadm")

# regDataseries(name = ds[1],
#               description = "Departamento Estadistico Nacional de Estadistica",
#               homepage = "https://www.dane.gov.co/",
#               version = _INSERT,
#               licence_link = _INSERT)

regDataseries(name = ds[2],
              description = "Instituto Colombiano Agropecuario",
              homepage = "https://www.ica.gov.co/",
              version = "2025.01",
              licence_link = "https://www.ica.gov.co/home/terminos-y-condiciones")


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

  schema_livestock_ica <- setCluster(id = _INSERT) |>
    setFormat(header = _INSERT, decimal = _INSERT, thousand = _INSERT,
              na_values = _INSERT) |>
    setFilter() |>
    setIDVar(name = "ADM1", ) |>
    setIDVar(name = "ADM2", ) |>
    setIDVar(name = "year", ) |>
    setIDVar(name = "method", value = "") |>
    setIDVar(name = "animal", ) |>
    setObsVar(name = "number_heads", )

  ### 2016 ----
  regTable(al1 = !!thisNation,
           label = "ADM2",
           subset = "aves",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_ica,
           begin = 2016,
           end = 2016,
           archive = "Aves-por-Muni-y-Dpto-2016.xlsx",
           archiveLink = "https://www.ica.gov.co/Areas/Pecuaria/Servicios/Epidemiologia-Veterinaria/Censos-2016/Censo-2016/Aves-por-Muni-y-Dpto-2016.aspx",
           downloadDate = ymd("2025-01-15"),
           updateFrequency = "annually",
           metadataLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "ADM2",
           subset = "bovinos",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_ica,
           begin = 2016,
           end = 2016,
           archive = "Bovinos-por-Muni-y-Dpto-2016.xlsx",
           archiveLink = "https://www.ica.gov.co/Areas/Pecuaria/Servicios/Epidemiologia-Veterinaria/Censos-2016/Censo-2016/Bovinos-por-Muni-y-Dpto-2016.aspx",
           downloadDate = ymd("2025-01-15"),
           updateFrequency = "annually",
           metadataLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "ADM2",
           subset = "bufalos",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_ica,
           begin = 2016,
           end = 2016,
           archive = "Bufalos-por-Muni-y-Dpto-2016.xlsx",
           archiveLink = "https://www.ica.gov.co/Areas/Pecuaria/Servicios/Epidemiologia-Veterinaria/Censos-2016/Censo-2016/Bufalos-por-Muni-y-Dpto-2016.aspx",
           downloadDate = ymd("2025-01-15"),
           updateFrequency = "annually",
           metadataLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "ADM2",
           subset = "caprinos",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_ica,
           begin = 2016,
           end = 2016,
           archive = "Caprinos-por-Muni-y-Dpto-2016.xlsx",
           archiveLink = "https://www.ica.gov.co/Areas/Pecuaria/Servicios/Epidemiologia-Veterinaria/Censos-2016/Censo-2016/Caprinos-por-Muni-y-Dpto-2016.aspx",
           downloadDate = ymd("2025-01-15"),
           updateFrequency = "annually",
           metadataLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "ADM2",
           subset = "equinos",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_ica,
           begin = 2016,
           end = 2016,
           archive = "Equinos-por-Muni-y-Dpto-2016.xlsx",
           archiveLink = "https://www.ica.gov.co/Areas/Pecuaria/Servicios/Epidemiologia-Veterinaria/Censos-2016/Censo-2016/Equinos-por-Muni-y-Dpto-2016.aspx",
           downloadDate = ymd("2025-01-15"),
           updateFrequency = "annually",
           metadataLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "ADM2",
           subset = "ovinos",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_ica,
           begin = 2016,
           end = 2016,
           archive = "Ovinos-por-Muni-y-Dpto-2016.xlsx",
           archiveLink = "https://www.ica.gov.co/Areas/Pecuaria/Servicios/Epidemiologia-Veterinaria/Censos-2016/Censo-2016/Ovinos-por-Muni-y-Dpto-2016.aspx",
           downloadDate = ymd("2025-01-15"),
           updateFrequency = "annually",
           metadataLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "ADM2",
           subset = "porcinos",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_ica,
           begin = 2016,
           end = 2016,
           archive = "Porcinos-por-Muni-y-Dpto-2016.xlsx",
           archiveLink = "https://www.ica.gov.co/Areas/Pecuaria/Servicios/Epidemiologia-Veterinaria/Censos-2016/Censo-2016/Porcinos-por-Muni-y-Dpto-2016.aspx",
           downloadDate = ymd("2025-01-15"),
           updateFrequency = "annually",
           metadataLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016",
           metadataPath = "unknown",
           overwrite = TRUE)

  ### 2017 ----
  regTable(al1 = !!thisNation,
           label = "ADM2",
           subset = "aves",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_ica,
           begin = 2017,
           end = 2017,
           archive = "CENSO-AVES-2017-3.xlsx",
           archiveLink = "https://www.ica.gov.co/getattachment/Areas/Pecuaria/Servicios/Epidemiologia-Veterinaria/Censos-2016/Censo-2017/CENSO-AVES-2017-3.xlsx.aspx?lang=es-CO",
           downloadDate = ymd("2025-01-15"),
           updateFrequency = "annually",
           metadataLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2017",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "ADM2",
           subset = "bovino",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_ica,
           begin = 2017,
           end = 2017,
           archive = "CENSO-BOVINO-2017.xlsx",
           archiveLink = "https://www.ica.gov.co/getattachment/Areas/Pecuaria/Servicios/Epidemiologia-Veterinaria/Censos-2016/Censo-2017/CENSO-BOVINO-2017.xlsx.aspx?lang=es-CO",
           downloadDate = ymd("2025-01-15"),
           updateFrequency = "annually",
           metadataLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2017",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "ADM2",
           subset = "bufalino",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_ica,
           begin = 2017,
           end = 2017,
           archive = "CENSO-BUFALINO-2017.xlsx",
           archiveLink = "https://www.ica.gov.co/getattachment/Areas/Pecuaria/Servicios/Epidemiologia-Veterinaria/Censos-2016/Censo-2017/CENSO-BUFALINO-2017.xlsx.aspx?lang=es-CO",
           downloadDate = ymd("2025-01-15"),
           updateFrequency = "annually",
           metadataLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2017",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "ADM2",
           subset = "caprino",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_ica,
           begin = 2017,
           end = 2017,
           archive = "CENSO-CAPRINO-2017.xlsx",
           archiveLink = "https://www.ica.gov.co/getattachment/Areas/Pecuaria/Servicios/Epidemiologia-Veterinaria/Censos-2016/Censo-2017/CENSO-CAPRINO-2017.xlsx.aspx?lang=es-CO",
           downloadDate = ymd("2025-01-15"),
           updateFrequency = "annually",
           metadataLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2017",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "ADM2",
           subset = "equino",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_ica,
           begin = 2017,
           end = 2017,
           archive = "CENSO-EQUINO-2017-1.xlsx",
           archiveLink = "https://www.ica.gov.co/getattachment/Areas/Pecuaria/Servicios/Epidemiologia-Veterinaria/Censos-2016/Censo-2017/CENSO-EQUINO-2017-1.xlsx.aspx?lang=es-CO",
           downloadDate = ymd("2025-01-15"),
           updateFrequency = "annually",
           metadataLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2017",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "ADM2",
           subset = "ovino",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_ica,
           begin = 2017,
           end = 2017,
           archive = "CENSO-OVINO-2017.xlsx",
           archiveLink = "https://www.ica.gov.co/getattachment/Areas/Pecuaria/Servicios/Epidemiologia-Veterinaria/Censos-2016/Censo-2017/CENSO-OVINO-2017.xlsx.aspx?lang=es-CO",
           downloadDate = ymd("2025-01-15"),
           updateFrequency = "annually",
           metadataLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2017",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "ADM2",
           subset = "porcino",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_ica,
           begin = 2017,
           end = 2017,
           archive = "CENSO-PORCINO-2017.xlsx",
           archiveLink = "https://www.ica.gov.co/getattachment/Areas/Pecuaria/Servicios/Epidemiologia-Veterinaria/Censos-2016/Censo-2017/CENSO-PORCINO-2017.xlsx.aspx?lang=es-CO",
           downloadDate = ymd("2025-01-15"),
           updateFrequency = "annually",
           metadataLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2017",
           metadataPath = "unknown",
           overwrite = TRUE)

  ### 2018 ----
  regTable(al1 = !!thisNation,
           label = "ADM2",
           subset = "aves",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_ica,
           begin = 2018,
           end = 2018,
           archive = "CENSO-AVES-2018.xlsx",
           archiveLink = "https://www.ica.gov.co/getattachment/Areas/Pecuaria/Servicios/Epidemiologia-Veterinaria/Censos-2016/Censo-2018/CENSO-AVES-2018.xlsx.aspx?lang=es-CO",
           downloadDate = ymd("2025-01-15"),
           updateFrequency = "annually",
           metadataLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2018",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "ADM2",
           subset = "bovinos",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_ica,
           begin = 2018,
           end = 2018,
           archive = "CENSO-BOVINOS-POR-DEPARTAMENTO-2018.xlsx",
           archiveLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2018/censo-bovinos-por-departamento-2018.aspx",
           downloadDate = ymd("2025-01-15"),
           updateFrequency = "annually",
           metadataLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2018",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "ADM2",
           subset = "bufalos",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_ica,
           begin = 2018,
           end = 2018,
           archive = "CENSO-BUFALOS-2018.xlsx",
           archiveLink = "https://www.ica.gov.co/getattachment/Areas/Pecuaria/Servicios/Epidemiologia-Veterinaria/Censos-2016/Censo-2018/CENSO-BUFALOS-2018.xlsx.aspx?lang=es-CO",
           downloadDate = ymd("2025-01-15"),
           updateFrequency = "annually",
           metadataLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2018",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "ADM2",
           subset = "caprinos",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_ica,
           begin = 2018,
           end = 2018,
           archive = "CENSO-CAPRINOS-2018.xlsx",
           archiveLink = "https://www.ica.gov.co/getattachment/Areas/Pecuaria/Servicios/Epidemiologia-Veterinaria/Censos-2016/Censo-2018/CENSO-CAPRINOS-2018.xlsx.aspx?lang=es-CO",
           downloadDate = ymd("2025-01-15"),
           updateFrequency = "annually",
           metadataLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2018",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "ADM2",
           subset = "equinos",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_ica,
           begin = 2018,
           end = 2018,
           archive = "CENSO-EQUINOS-2018.xlsx",
           archiveLink = "https://www.ica.gov.co/getattachment/Areas/Pecuaria/Servicios/Epidemiologia-Veterinaria/Censos-2016/Censo-2018/CENSO-EQUINOS-2018.xlsx.aspx?lang=es-CO",
           downloadDate = ymd("2025-01-15"),
           updateFrequency = "annually",
           metadataLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2018",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "ADM2",
           subset = "ovinos",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_ica,
           begin = 2018,
           end = 2018,
           archive = "CENSO-OVINOS-2018.xlsx",
           archiveLink = "https://www.ica.gov.co/getattachment/Areas/Pecuaria/Servicios/Epidemiologia-Veterinaria/Censos-2016/Censo-2018/CENSO-OVINOS-2018.xlsx.aspx?lang=es-CO",
           downloadDate = ymd("2025-01-15"),
           updateFrequency = "annually",
           metadataLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2018",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "ADM2",
           subset = "porcinos",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_ica,
           begin = 2018,
           end = 2018,
           archive = "CENSO-PORCINOS-2018.xlsx",
           archiveLink = "https://www.ica.gov.co/getattachment/Areas/Pecuaria/Servicios/Epidemiologia-Veterinaria/Censos-2016/Censo-2018/CENSO-PORCINOS-2018.xlsx.aspx?lang=es-CO",
           downloadDate = ymd("2025-01-15"),
           updateFrequency = "annually",
           metadataLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2018",
           metadataPath = "unknown",
           overwrite = TRUE)

  ### 2019 ----
  regTable(al1 = !!thisNation,
           label = "ADM2",
           subset = "",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_ica,
           begin = 2019,
           end = 2019,
           archive = "",
           archiveLink = "",
           downloadDate = ymd("2025-01-15"),
           updateFrequency = "annually",
           metadataLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2018",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "ADM2",
           subset = "",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_ica,
           begin = 2019,
           end = 2019,
           archive = "",
           archiveLink = "",
           downloadDate = ymd("2025-01-15"),
           updateFrequency = "annually",
           metadataLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2018",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "ADM2",
           subset = "",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_ica,
           begin = 2019,
           end = 2019,
           archive = "",
           archiveLink = "",
           downloadDate = ymd("2025-01-15"),
           updateFrequency = "annually",
           metadataLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2018",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "ADM2",
           subset = "",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_ica,
           begin = 2019,
           end = 2019,
           archive = "",
           archiveLink = "",
           downloadDate = ymd("2025-01-15"),
           updateFrequency = "annually",
           metadataLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2018",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "ADM2",
           subset = "",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_ica,
           begin = 2019,
           end = 2019,
           archive = "",
           archiveLink = "",
           downloadDate = ymd("2025-01-15"),
           updateFrequency = "annually",
           metadataLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2018",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "ADM2",
           subset = "",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_ica,
           begin = 2019,
           end = 2019,
           archive = "",
           archiveLink = "",
           downloadDate = ymd("2025-01-15"),
           updateFrequency = "annually",
           metadataLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2018",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "ADM2",
           subset = "",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_ica,
           begin = 2019,
           end = 2019,
           archive = "",
           archiveLink = "",
           downloadDate = ymd("2025-01-15"),
           updateFrequency = "annually",
           metadataLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2018",
           metadataPath = "unknown",
           overwrite = TRUE)

  ### 2020 ----
  regTable(al1 = !!thisNation,
           label = "ADM2",
           subset = "aves",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_ica,
           begin = 2020,
           end = 2020,
           archive = "AVES-CENSOS-2020.xlsx",
           archiveLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2020/aves-censos-2020.aspx",
           downloadDate = ymd("2025-01-15"),
           updateFrequency = "annually",
           metadataLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2018",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "ADM2",
           subset = "bovinos",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_ica,
           begin = 2020,
           end = 2020,
           archive = "BOVINOS-CENSO-2020.xlsx",
           archiveLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2020/bovinos-censo-2020.aspx",
           downloadDate = ymd("2025-01-15"),
           updateFrequency = "annually",
           metadataLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2018",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "ADM2",
           subset = "bufalos",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_ica,
           begin = 2020,
           end = 2020,
           archive = "BUFALOS-CENSO-2020.xlsx",
           archiveLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2020/bufalos-censo-2020.aspx",
           downloadDate = ymd("2025-01-15"),
           updateFrequency = "annually",
           metadataLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2018",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "ADM2",
           subset = "equinosCaprinosOvinos",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_ica,
           begin = 2020,
           end = 2020,
           archive = "Equinos-Caprinos-Ovinos-CENSOS-2020.xlsx",
           archiveLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2020/equinos-caprinos-ovinos-censos-2020-2.aspx",
           downloadDate = ymd("2025-01-15"),
           updateFrequency = "annually",
           metadataLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2018",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "ADM2",
           subset = "porcinos",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_ica,
           begin = 2020,
           end = 2020,
           archive = "PORCINOS-CENSOS-2020.xlsx",
           archiveLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2020/porcinos-censos-2020.aspx",
           downloadDate = ymd("2025-01-15"),
           updateFrequency = "annually",
           metadataLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2018",
           metadataPath = "unknown",
           overwrite = TRUE)

  ### 2021 ----
  regTable(al1 = !!thisNation,
           label = "ADM2",
           subset = "aves",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_ica,
           begin = 2021,
           end = 2021,
           archive = "CENSO-AVES-2021.xlsx",
           archiveLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2018/censo-aves-2021.aspx",
           downloadDate = ymd("2025-01-15"),
           updateFrequency = "annually",
           metadataLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2018",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "ADM2",
           subset = "bovino",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_ica,
           begin = 2021,
           end = 2021,
           archive = "CENSO-BOVINO-2021.xlsx",
           archiveLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2018/censo-bovino-2021-1.aspx",
           downloadDate = ymd("2025-01-15"),
           updateFrequency = "annually",
           metadataLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2018",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "ADM2",
           subset = "bufalo",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_ica,
           begin = 2021,
           end = 2021,
           archive = "CENSO-BUFALO-2021.xlsx",
           archiveLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2018/censo-bufalo-202.aspx",
           downloadDate = ymd("2025-01-15"),
           updateFrequency = "annually",
           metadataLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2018",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "ADM2",
           subset = "porcino",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_ica,
           begin = 2021,
           end = 2021,
           archive = "CENSO-PORCINO-2021.xlsx",
           archiveLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2018/censo-porcino-2021.aspx",
           downloadDate = ymd("2025-01-15"),
           updateFrequency = "annually",
           metadataLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2018",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "ADM2",
           subset = "equinosOvinosCaprinos",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_ica,
           begin = 2021,
           end = 2021,
           archive = "CENSOS-EQUINOS-OVINOS-CAPRINOS-2021.xlsx",
           archiveLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2018/censos-equinos-ovinos-caprinos-2021.aspx",
           downloadDate = ymd("2025-01-15"),
           updateFrequency = "annually",
           metadataLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2018",
           metadataPath = "unknown",
           overwrite = TRUE)

  ### 2022 ----
  regTable(al1 = !!thisNation,
           label = "ADM2",
           subset = "aves",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_ica,
           begin = 2022,
           end = 2022,
           archive = "CENSOS-AVES-2022.xlsx",
           archiveLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2018/censos-aves-2022.aspx",
           downloadDate = ymd("2025-01-15"),
           updateFrequency = "annually",
           metadataLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2018",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "ADM2",
           subset = "bovinos",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_ica,
           begin = 2022,
           end = 2022,
           archive = "CENSOS-BOVINOS-2022.xlsx",
           archiveLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2018/censos-bovinos-2022.aspx",
           downloadDate = ymd("2025-01-15"),
           updateFrequency = "annually",
           metadataLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2018",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "ADM2",
           subset = "bufalos",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_ica,
           begin = 2022,
           end = 2022,
           archive = "CENSOS-BUFALOS-2022.xlsx",
           archiveLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2018/censos-bufalos-2022.aspx",
           downloadDate = ymd("2025-01-15"),
           updateFrequency = "annually",
           metadataLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2018",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "ADM2",
           subset = "otras",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_ica,
           begin = 2022,
           end = 2022,
           archive = "CENSOS-OTRAS-ESPECIES-2022.xlsx",
           archiveLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2018/censos-otras-especies-2022-1.aspx",
           downloadDate = ymd("2025-01-15"),
           updateFrequency = "annually",
           metadataLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2018",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "ADM2",
           subset = "porcinos",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_ica,
           begin = 2022,
           end = 2022,
           archive = "CENSOS-PORCINOS-2022.xlsx",
           archiveLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2018/censo-porcinos-2022.aspx",
           downloadDate = ymd("2025-01-15"),
           updateFrequency = "annually",
           metadataLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2018",
           metadataPath = "unknown",
           overwrite = TRUE)

  ### 2023 ----
  regTable(al1 = !!thisNation,
           label = "ADM2",
           subset = "aves",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_ica,
           begin = 2023,
           end = 2023,
           archive = "CENSOS-AVES-2023-Final.xls",
           archiveLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-aves-2023-final.aspx",
           downloadDate = ymd("2025-01-15"),
           updateFrequency = "annually",
           metadataLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2018",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "ADM2",
           subset = "bovinos",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_ica,
           begin = 2023,
           end = 2023,
           archive = "CENSOS-BOVINOS-2023-Final.xls",
           archiveLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-bovinos-2023-final.aspx",
           downloadDate = ymd("2025-01-15"),
           updateFrequency = "annually",
           metadataLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2018",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "ADM2",
           subset = "bufalos",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_ica,
           begin = 2023,
           end = 2023,
           archive = "CENSOS-BUFALOS-2023-Final.xls",
           archiveLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-bufalos-2023-final.aspx",
           downloadDate = ymd("2025-01-15"),
           updateFrequency = "annually",
           metadataLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2018",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "ADM2",
           subset = "caprinosOvinos",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_ica,
           begin = 2023,
           end = 2023,
           archive = "CENSOS-CAPRINOS-Y-OVINOS-2023-Final.xls",
           archiveLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-caprinos-y-ovinos-2023-final.aspx",
           downloadDate = ymd("2025-01-15"),
           updateFrequency = "annually",
           metadataLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2018",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "ADM2",
           subset = "equinos",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_ica,
           begin = 2023,
           end = 2023,
           archive = "CENSOS-EQUINOS-2023-Final.xls",
           archiveLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-equinos-2023-final.aspx",
           downloadDate = ymd("2025-01-15"),
           updateFrequency = "annually",
           metadataLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2018",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "ADM2",
           subset = "porcinos",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_ica,
           begin = 2023,
           end = 2023,
           archive = "CENSOS-PORCINOS-2023-filtros-habilitados.xlsx",
           archiveLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/bol/epi/boletines-seccionales/2021-1/censo-porcinos-2023-filtros-habilitados.aspx",
           downloadDate = ymd("2025-01-15"),
           updateFrequency = "annually",
           metadataLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2018",
           metadataPath = "unknown",
           overwrite = TRUE)


  ### 2024 ----
  regTable(al1 = !!thisNation,
           label = "ADM2",
           subset = "bovinos",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_ica,
           begin = 2024,
           end = 2024,
           archive = "CENSO-BOVINO-FINAL.xlsx",
           archiveLink = "https://www.ica.gov.co/areas/pecuaria/servicios/enfermedades-animales/fiebre-aftosa/censo-bovino-final.aspx",
           downloadDate = ymd("2025-01-15"),
           updateFrequency = "annually",
           metadataLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2018",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "ADM2",
           subset = "bufalos",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_ica,
           begin = 2024,
           end = 2024,
           archive = "CENSO-BUFALINO-FINAL.xlsx",
           archiveLink = "https://www.ica.gov.co/areas/pecuaria/servicios/enfermedades-animales/fiebre-aftosa/censo-bufalino-final.aspx",
           downloadDate = ymd("2025-01-15"),
           updateFrequency = "annually",
           metadataLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2018",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "ADM2",
           subset = "caprinosOvinos",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_ica,
           begin = 2024,
           end = 2024,
           archive = "censo-poblacion-ovina-por-municipio-y-departamento-2024_.xlsx",
           archiveLink = "https://www.ica.gov.co/areas/pecuaria/servicios/enfermedades-animales/fiebre-aftosa/censo-poblacion-ovina-por-municipio-y-departamento.aspx",
           downloadDate = ymd("2025-01-15"),
           updateFrequency = "annually",
           metadataLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2018",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "ADM2",
           subset = "porcinos",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_ica,
           begin = 2024,
           end = 2024,
           archive = "CENSOS-PORCINOS-2024_FINAL.xlsx",
           archiveLink = "https://www.ica.gov.co/areas/pecuaria/servicios/enfermedades-animales/fiebre-aftosa/censos-porcinos-2024_final.aspx",
           downloadDate = ymd("2025-01-15"),
           updateFrequency = "annually",
           metadataLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2018",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "ADM2",
           subset = "aves",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_ica,
           begin = 2024,
           end = 2024,
           archive = "TABLA-DE-POBLACION-AVIAR-2024_final.xlsx",
           archiveLink = "https://www.ica.gov.co/areas/pecuaria/servicios/enfermedades-animales/fiebre-aftosa/tabla-de-poblacion-aviar-2024_final.aspx",
           downloadDate = ymd("2025-01-15"),
           updateFrequency = "annually",
           metadataLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2018",
           metadataPath = "unknown",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "ADM2",
           subset = "equina",
           dSeries = ds[2],
           gSeries = gs[1],
           schema = schema_livestock_ica,
           begin = 2024,
           end = 2024,
           archive = "Tabla-de-poblacion-equina-por-municipio-y-departamento-2024-final.xlsx",
           archiveLink = "https://www.ica.gov.co/areas/pecuaria/servicios/enfermedades-animales/fiebre-aftosa/tabla-de-poblacion-equina-por-municipio-y-depa-1.aspx",
           downloadDate = ymd("2025-01-15"),
           updateFrequency = "annually",
           metadataLink = "https://www.ica.gov.co/areas/pecuaria/servicios/epidemiologia-veterinaria/censos-2016/censo-2018",
           metadataPath = "unknown",
           overwrite = TRUE)

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
myRoot <- paste0(dir_census_data, "tables/stage2/")
myFile <- "Brazil_ADM2_bubalino_1990_2022_ibge.csv"
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
              level = "ADM2",
              year = 2000:2020,
              animate = TRUE)
