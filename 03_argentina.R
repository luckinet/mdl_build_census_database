# ----
# title       : build census database - ign, senasa
# description : this script integrates data of 'Instituto Geografico Nacional' (http://www.ign.gob.ar), 'Ministerio de Agricultura, Ganaderia y Pesca' (https://www.argentina.gob.ar/senasa)
# license     : https://creativecommons.org/licenses/by-sa/4.0/
# authors     : Steffen Ehrmann
# date        : 2025-01-31
# version     : 1.0.0
# status      : finished
# notes       : see 00_main.R
# ----
# geography   : Argentina
# spatial     : ADM0, ADM1, ADM2
# period      : 1970 - 2020
# variables   :
# - land      : hectares_covered
# - crops     : hectares_planted, hectares_harvested, tons_produced, kiloPerHectare_yield
# - livestock : number_heads
# - tech      : -
# - social    : -
# sampling    : survey, census
# comment     : _INSERT
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
schema_senasa2 <-
  setIDVar(name = "ADM1", columns = 2) %>%
  setIDVar(name = "ADM2", columns = 4) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "method", value = "survey") %>%
  setIDVar(name = "animal", columns = c(6:14), rows = 1) %>%
  setObsVar(name = "number_heads", columns = c(6:14))

regTable(ADM0 = !!thisNation,
         label = "ADM2",
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
  setIDVar(name = "ADM1", columns = 2) %>%
  setIDVar(name = "ADM2", columns = 4) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "method", value = "survey") %>%
  setIDVar(name = "animal", columns = c(6:11), rows = 1) %>%
  setObsVar(name = "number_heads", columns = c(6:11))

regTable(ADM0 = !!thisNation,
         label = "ADM2",
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

regTable(ADM0 = !!thisNation,
         label = "ADM2",
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
  setIDVar(name = "ADM1", columns = 2) %>%
  setIDVar(name = "ADM2", columns = 4) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "method", value = "survey") %>%
  setIDVar(name = "animal", columns = c(6:10), rows = 1) %>%
  setObsVar(name = "number_heads", columns = c(6:10))

regTable(ADM0 = !!thisNation,
         label = "ADM2",
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
  setIDVar(name = "ADM1", columns = 2) %>%
  setIDVar(name = "ADM2", columns = 4) %>%
  setIDVar(name = "year", columns = 1) %>%
  setIDVar(name = "method", value = "survey") %>%
  setIDVar(name = "animal", columns = c(6:12), rows = 1) %>%
  setObsVar(name = "number_heads", columns = c(6:12))

regTable(ADM0 = !!thisNation,
         label = "ADM2",
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

normTable(pattern = paste0("ADM2.*", ds[1]),
          ontoMatch = "animal",
          beep = 10)
