# ----
# title       : build census database - ign, senasa
# description : this script integrates data of 'Instituto Geografico Nacional' (http://www.ign.gob.ar), 'Ministerio de Agricultura, Ganaderia y Pesca' (https://www.argentina.gob.ar/senasa)
# license     : https://creativecommons.org/licenses/by-sa/4.0/
# authors     : Steffen Ehrmann
# date        : 2024-06-07
# version     : 1.0.0
# status      : done
# comment     : -
# ----
# geography   : Argentina
# spatial     : País, Provincias, Departmentos
# period      : 1970 - 2020
# variables   :
# - land      : hectares_covered
# - crops     : hectares_planted, hectares_harvested, tons_produced, kiloPerHectare_yield
# - livestock : number_heads
# - tech      : -
# - social    : -
# sampling    : survey, census
# ----

thisNation <- "Argentina"

ds <- c("senasa")
gs <- c("ign")


# 1. dataseries ----
#
regDataseries(name = gs[1],
              description = "Instituto Geografico Nacional",
              homepage = "http://www.ign.gob.ar",
              version = "2023.12",
              licence_link = "unknown")

regDataseries(name = ds[1],
              description = "Ministerio de Agricultura, Ganaderia y Pesca",
              homepage = "https://www.argentina.gob.ar/senasa",
              version = "2023.12",
              licence_link = "unknown")


# 2. geometries ----
#
regGeometry(al1 = !!thisNation,
            gSeries = gs[1],
            label = list(al1 = "NAM"),
            archive = "pais.zip|País.shp",
            archiveLink = "http://www.ign.gob.ar/NuestrasActividades/InformacionGeoespacial/CapasSIG",
            downloadDate = ymd("2019-10-10"),
            updateFrequency = "notPlanned")

regGeometry(al1 = !!thisNation,
            gSeries = gs[1],
            label = list(al2 = "NAM"),
            archive = "PROVINCIAS.zip|Provincias.shp",
            archiveLink = "http://www.ign.gob.ar/NuestrasActividades/InformacionGeoespacial/CapasSIG",
            downloadDate = ymd("2019-10-10"),
            updateFrequency = "notPlanned")

regGeometry(al1 = !!thisNation,
            gSeries = gs[1],
            label = list(al3 = "NAM"),
            archive = "DEPARTAMENTOS.zip|Departamentos.shp",
            archiveLink = "http://www.ign.gob.ar/NuestrasActividades/InformacionGeoespacial/CapasSIG",
            downloadDate = ymd("2019-10-10"),
            updateFrequency = "notPlanned")

normGeometry(pattern = gs[1],
             beep = 10)


# 3. tables ----
#
if(build_crops){
  ## crops ----

  schema_senasa1 <-
    setIDVar(name = "al2", columns = 2) %>%
    setIDVar(name = "al3", columns = 4) %>%
    setIDVar(name = "year", columns = 8, split = "((?<=\\/).*)") %>%
    setIDVar(name = "method", value = "survey") %>%
    setIDVar(name = "crop", columns = 6) %>%
    setObsVar(name = "hectares_planted", columns = 9) %>%
    setObsVar(name = "hectares_harvested", columns = 10) %>%
    setObsVar(name = "tons_produced", columns = 11) %>%
    setObsVar(name = "kilo_per_hectare_yield", columns = 12)

  regTable(al1 = !!thisNation,
           label = "al3",
           subset = "crops",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_senasa1,
           begin = 1970,
           end = 2020,
           archive = "estimaciones-agricolas-2020-08.csv",
           archiveLink = "https://datos.magyp.gob.ar/dataset/estimaciones-agricolas",
           updateFrequency = "annually",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "unknown",
           metadataLink = "https://datos.magyp.gob.ar/dataset/estimaciones-agricolas/archivo/95d066e6-8a0f-4a80-b59d-6f28f88eacd5",
           overwrite = TRUE)

  normTable(pattern = paste0("crops.*", ds[1]),
            ontoMatch = "crop",
            beep = 10)
}

if(build_livestock){
  ## livestock ----

  schema_senasa2 <-
    setIDVar(name = "al2", columns = 2) %>%
    setIDVar(name = "al3", columns = 4) %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "method", value = "survey") %>%
    setIDVar(name = "animal", columns = c(6:14), rows = 1) %>%
    setObsVar(name = "number_heads", columns = c(6:14))

  regTable(al1 = !!thisNation,
           label = "al3",
           subset = "bovines",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_senasa2,
           begin = 2008,
           end = 2019,
           archive = "existencias-bovinas-provincia-departamento-2008-2019.csv",
           archiveLink = "https://datos.agroindustria.gob.ar/dataset/c19a5875-fb39-48b6-b0b2-234382722afb/resource/1b920477-8112-4e12-bc2c-94b564f04183/download/existencias-bovinas-provincia-departamento-2008-2019.csv",
           updateFrequency = "annually",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "unknown",
           metadataLink = "https://datos.agroindustria.gob.ar/dataset/senasa-existencias-bovinas",
           overwrite = TRUE)

  schema_senasa3 <-
    setIDVar(name = "al2", columns = 2) %>%
    setIDVar(name = "al3", columns = 4) %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "method", value = "survey") %>%
    setIDVar(name = "animal", columns = c(6:11), rows = 1) %>%
    setObsVar(name = "number_heads", columns = c(6:11))

  regTable(al1 = !!thisNation,
           label = "al3",
           subset = "equines",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_senasa3,
           begin = 2008,
           end = 2019,
           archive = "existencias-equinas-provincia-departamento-2008-2019.csv",
           archiveLink = "https://datos.agroindustria.gob.ar/dataset/4e58e69d-317a-4666-b70e-c668b43cdf16/resource/47b0bbc7-3ca2-4909-a29e-54be64b180c6/download/existencias-equinas-provincia-departamento-2008-2019.csv",
           updateFrequency = "annually",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "unknown",
           metadataLink = "https://datos.agroindustria.gob.ar/dataset/senasa-existencias-equinas",
           overwrite = TRUE)

  regTable(al1 = !!thisNation,
           label = "al3",
           subset = "goats",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_senasa3,
           begin = 2008,
           end = 2019,
           archive = "existencias-caprinas-provincia-departamento-2008-2019.csv",
           archiveLink = "https://datos.agroindustria.gob.ar/dataset/10be262c-e6b2-484c-9bb7-ec74b3b5bbc7/resource/5a4d55ff-464e-41bb-b3be-4aaad020bf35/download/existencias_caprinas.csv",
           updateFrequency = "annually",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "unknown",
           metadataLink = "https://datos.agroindustria.gob.ar/dataset/senasa-existencias-caprinas",
           overwrite = TRUE)

  schema_senasa4 <-
    setIDVar(name = "al2", columns = 2) %>%
    setIDVar(name = "al3", columns = 4) %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "method", value = "survey") %>%
    setIDVar(name = "animal", columns = c(6:10), rows = 1) %>%
    setObsVar(name = "number_heads", columns = c(6:10))

  regTable(al1 = !!thisNation,
           label = "al3",
           subset = "sheep",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_senasa4,
           begin = 2008,
           end = 2019,
           archive = "existencias-ovinas-provincia-departamento-2008-2019.csv",
           archiveLink = "https://datos.agroindustria.gob.ar/dataset/107f502f-d0f8-4835-860e-cc7d2fc5425f/resource/5dfb3c49-7260-4dc4-afa3-95f3459754a6/download/existencias-ovinas-provincia-departamento-2008-2019.csv",
           updateFrequency = "annually",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "unknown",
           metadataLink = "https://datos.agroindustria.gob.ar/dataset/senasa-existencias-ovinas",
           overwrite = TRUE)

  schema_senasa5 <-
    setIDVar(name = "al2", columns = 2) %>%
    setIDVar(name = "al3", columns = 4) %>%
    setIDVar(name = "year", columns = 1) %>%
    setIDVar(name = "method", value = "survey") %>%
    setIDVar(name = "animal", columns = c(6:12), rows = 1) %>%
    setObsVar(name = "number_heads", columns = c(6:12))

  regTable(al1 = !!thisNation,
           label = "al3",
           subset = "pigs",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_senasa5,
           begin = 2008,
           end = 2019,
           archive = "existencias-porcinas-provincia-departamento-2008-2019.csv",
           archiveLink = "https://datos.agroindustria.gob.ar/dataset/7ca226f7-7727-44e8-9006-e9cabd854cf5/resource/e2ab186a-465d-481d-9159-e145f1435074/download/existencias-porcinas-provincia-departamento-2008-2019.csv",
           updateFrequency = "annually",
           downloadDate = ymd("2019-10-10"),
           metadataPath = "unknown",
           metadataLink = "https://datos.agroindustria.gob.ar/dataset/senasa-existencias-porcinas",
           overwrite = TRUE)

  normTable(pattern = paste0("al3.*", ds[1]),
            ontoMatch = "animal",
            beep = 10)

}

if(build_landuse){
  ## landuse ----

  schema_senasa6 <-
    setIDVar(name = "al1", columns = 2) %>%
    setIDVar(name = "al2", columns = 4) %>%
    setIDVar(name = "method", value = "survey") %>%
    setIDVar(name = "year", columns = 14) %>%
    setIDVar(name = "landuse", columns = c(7:10), rows = 1) %>%
    setObsVar(name = "hectares_covered", columns = c(7:10), key = 5, value = "macizo")

  regTable(al1 = !!thisNation,
           label = "al2",
           subset = "plantation",
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_senasa6,
           begin = 2009,
           end = 2017,
           archive = "inventario-nacional-de-plantaciones-forestales-superficie-20180725.csv",
           archiveLink = "http://datosestimaciones.magyp.gob.ar/reportes.php?reporte=Estimaciones",
           updateFrequency = "not planned",
           downloadDate = ymd("2019-10-10"),
           metadataLink = "https://www.agroindustria.gob.ar/sitio/areas/estimaciones/estimaciones/metodologia/_archivos//000000_Metodo%20de%20segmentos%20aleatorios%20(Version%205).pdf",
           metadataPath = "/areal database/adb_tables/meta_maia",
           overwrite = TRUE)

  normTable(pattern = paste0("plantation.*", ds[1]),
            ontoMatch = "landuse",
            beep = 10)

}
