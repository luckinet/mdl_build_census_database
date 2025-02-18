# ----
# title       : build census database - rosstat
# description : this script integrates data of the Russian National Statistics Agency (www.fedstat.ru)
# license     : https://creativecommons.org/licenses/by-sa/4.0/
# authors     : Steffen Ehrmann
# date        : 2025-01-31
# version     : 0.7.0
# status      : work in progress [70%]
# notes       : see 00_main.R
# ----
# geography   : Russian Federation
# spatial     : ADM0, ADM1, ADM2
# period      : 2007 - 2022
# variables   :
# - land      : -
# - crops     : -
# - livestock : number_heads, colonies
# - tech      : -
# - social    : -
# sampling    : survey
# comment     : look for some more older data (should be available at lower level); check misaligned files
# ----

thisNation <- "Russian Federation"
# source(paste0(.get_path("cens"), "preprocess_rosstat.R"))

ds <- c("rosstat")
gs <- c("gadm")


# 1. dataseries ----
#
regDataseries(name = ds[1],
              description = "Russian National Statistics Agency",
              homepage = "www.fedstat.ru",
              version = "2023.12",
              licence_link = "unknown")

locNames <- "голова|области|район|округ|огруг|город|поселок|центнеров с гектара|Республика|"

# 2. geometries ----
#
# based on GADM 3.6


# 3. tables ----
#
## yield ----
rosstat_yield <- list.files(path = paste0(.get_path("cens", "_data"), "tables/stage1/rosstat/"),
                            pattern = "yield")

for(i in seq_along(rosstat_yield)){

  thisFile <- rosstat_yield[i]
  name <- str_split(thisFile, "_")[[1]]
  munst <- name[2]
  ADM1Val <- str_split(name[1], "[.]")[[1]][1]

  schema_yield <-
    setCluster(id = "ADM2", left = 1, top = .find(pattern = "значение за год|значение показателя за год", col = 1)) |>
    setFilter(rows = .find(pattern = paste0(locNames, "центнеров с гектара|центнер с гектара|Центнер с гектара"), col = 1, invert = TRUE), clusters = FALSE) |>
    setIDVar(name = "ADM1", value = ADM1Val) |>
    setIDVar(name = "ADM2", columns = 1, split = "(?<=категорий\\, ).*", rows = .find(row = 1, relative = TRUE)) |>
    setIDVar(name = "year", columns = .find(fun = is.numeric, row = 2, relative = TRUE), rows = .find(row = 2, relative = TRUE)) |>
    setIDVar(name = "method", value = "survey") |>
    setIDVar(name = "crop", columns = 1) |>
    setObsVar(name = "kiloPerHectare_yield", factor = 100, columns = .find(fun = is.numeric, row = 2, relative = TRUE))

  regTable(ADM0 = !!thisNation,
           label = "ADM2",
           subset = paste0("yield", ADM1Val),
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_yield,
           begin = 2008,
           end = 2023,
           archive = thisFile,
           archiveLink = paste0("https://www.gks.ru/dbscripts/munst/munst", munst, "/DBInet.cgi"),
           downloadDate = dmy("05-02-2025"),
           updateFrequency = "annually",
           metadataLink = "unknown",
           metadataPath = "unknown",
           overwrite = TRUE)

}

normTable(pattern = paste0("yield.*", ds[1]),
          ontoMatch = "crop",
          simplify = list(squish = TRUE, lowercase = TRUE, dashes = TRUE,
                          duplpunct = TRUE,
                          remove = c("(?<=[\\p{L}+])_", "/", "\\*"),
                          replace = c(" - | -|- ", "-"),
                          replace = c("([(\\[{])\\s", "\\1"),
                          chartr = c("é", "e")),
          beep = 10)


## planted ----
rosstat_planted <- list.files(path = paste0(.get_path("cens", "_data"), "/tables/stage1/rosstat/"),
                              pattern = "planted")

for(i in seq_along(rosstat_planted)){

  thisFile <- rosstat_planted[i]
  name <- str_split(thisFile, "_")[[1]]
  munst <- name[2]
  ADM1Val <- str_split(name[1], "[.]")[[1]][1]

  schema_planted <-
    setCluster(id = "ADM2", left = 1, top = .find(pattern = "значение за год|значение показателя за год", col = 1)) |>
    setFilter(rows = .find(pattern = paste0(locNames, "центнеров с гектара|гектар"), col = 1, invert = TRUE), clusters = FALSE) |>
    setIDVar(name = "ADM1", value = ADM1Val) |>
    setIDVar(name = "ADM2", columns = 1, split = "(?<=категорий\\, ).*", rows = .find(row = 1, relative = TRUE)) |>
    setIDVar(name = "year", columns = .find(fun = is.numeric, row = 2, relative = TRUE), rows = .find(row = 2, relative = TRUE)) |>
    setIDVar(name = "method", value = "survey") |>
    setIDVar(name = "crop", columns = 1) |>
    setObsVar(name = "hectares_planted", columns = .find(fun = is.numeric, row = 2, relative = TRUE))

  regTable(ADM0 = !!thisNation,
           label = "ADM2",
           subset = paste0("planted", ADM1Val),
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_planted,
           begin = 2008,
           end = 2023,
           archive = thisFile,
           archiveLink = paste0("https://www.gks.ru/dbscripts/munst/munst", munst, "/DBInet.cgi"),
           downloadDate = dmy("05-02-2025"),
           updateFrequency = "annually",
           metadataLink = "unknown",
           metadataPath = "unknown",
           overwrite = TRUE)

}

normTable(pattern = paste0("planted.*", ds[1]),
          ontoMatch = "crop",
          beep = 10)


## production ----
rosstat_production <- list.files(path = paste0(.get_path("cens", "_data"), "/tables/stage1/rosstat/"),
                                 pattern = "production")

for(i in seq_along(rosstat_production)){

  thisFile <- rosstat_production[i]
  name <- str_split(thisFile, "_")[[1]]
  munst <- name[2]
  ADM1Val <- str_split(name[1], "[.]")[[1]][1]

  schema_production <-
    setCluster(id = "ADM2", left = 1, top = .find(pattern = "значение за год|значение показателя за год", col = 1)) |>
    setFilter(rows = .find(pattern = paste0(locNames, "центнер"), col = 1, invert = TRUE), clusters = FALSE) |>
    setIDVar(name = "ADM1", value = ADM1Val) |>
    setIDVar(name = "ADM2", columns = 1, split = "(?<=категорий\\, ).*", rows = .find(row = 1, relative = TRUE)) |>
    setIDVar(name = "year", columns = .find(fun = is.numeric, row = 2, relative = TRUE), rows = .find(row = 2, relative = TRUE)) |>
    setIDVar(name = "method", value = "survey") |>
    setIDVar(name = "crop", columns = 1) |>
    setObsVar(name = "tons_produced", columns = .find(fun = is.numeric, row = 2, relative = TRUE))

  regTable(ADM0 = !!thisNation,
           label = "ADM2",
           subset = paste0("production", ADM1Val),
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_production,
           begin = 2008,
           end = 2023,
           archive = thisFile,
           archiveLink = paste0("https://www.gks.ru/dbscripts/munst/munst", munst, "/DBInet.cgi"),
           downloadDate = dmy("05-02-2025"),
           updateFrequency = "annually",
           metadataLink = "unknown",
           metadataPath = "unknown",
           overwrite = TRUE)

}

normTable(pattern = paste0("production.*", ds[1]),
          ontoMatch = "crop",
          beep = 10)


## perennials ----
rosstat_perennial <- list.files(path = paste0(.get_path("cens", "_data"), "/tables/stage1/rosstat/"),
                                pattern = "perennial")

for(i in seq_along(rosstat_perennial)){

  thisFile <- rosstat_perennial[i]
  name <- str_split(thisFile, "_")[[1]]
  munst <- name[2]
  ADM1Val <- str_split(name[1], "[.]")[[1]][1]

  schema_perennial <-
    setCluster(id = "ADM2", left = 1, top = .find(pattern = "значение за год|значение показателя за год", col = 1)) |>
    setFilter(rows = .find(pattern = paste0(locNames, "гектар"), col = 1, invert = TRUE), clusters = FALSE) |>
    setIDVar(name = "ADM1", value = ADM1Val) |>
    setIDVar(name = "ADM2", columns = 1, split = "(?<=категорий\\, ).*", rows = .find(row = 1, relative = TRUE)) |>
    setIDVar(name = "year", columns = .find(fun = is.numeric, row = 2, relative = TRUE), rows = .find(row = 2, relative = TRUE)) |>
    setIDVar(name = "method", value = "survey") |>
    setIDVar(name = "crop", columns = 1) |>
    setObsVar(name = "hectares_planted", columns = .find(fun = is.numeric, row = 2, relative = TRUE))

  regTable(ADM0 = !!thisNation,
           label = "ADM2",
           subset = paste0("perennial", ADM1Val),
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_perennial,
           begin = 2008,
           end = 2023,
           archive = thisFile,
           archiveLink = paste0("https://www.gks.ru/dbscripts/munst/munst", munst, "/DBInet.cgi"),
           downloadDate = dmy("05-02-2025"),
           updateFrequency = "annually",
           metadataLink = "unknown",
           metadataPath = "unknown",
           overwrite = TRUE)

}

normTable(pattern = paste0("perennial.*", ds[1]),
          ontoMatch = "crop",
          beep = 10)


## livestock ----
rosstat_livestock <- list.files(path = paste0(.get_path("cens", "_data"), "/tables/stage1/rosstat/"),
                                pattern = "livestock")

for(i in seq_along(rosstat_livestock)){

  thisFile <- rosstat_livestock[i]
  name <- str_split(thisFile, "_")[[1]]
  munst <- name[2]
  ADM1Val <- str_split(name[1], "[.]")[[1]][1]

  schema_livestock <-
    setCluster(id = "ADM2", left = 1, top = .find(pattern = "значение за год|значение показателя за год", col = 1)) |>
    setFilter(rows = .find(pattern = paste0(locNames, "голов"), col = 1, invert = TRUE), clusters = FALSE) |>
    setIDVar(name = "ADM1", value = ADM1Val) |>
    setIDVar(name = "ADM2", columns = 1, split = "(?<=категорий\\, ).*", rows = .find(row = 1, relative = TRUE)) |>
    setIDVar(name = "year", columns = .find(fun = is.numeric, row = 2, relative = TRUE), rows = .find(row = 2, relative = TRUE)) |>
    setIDVar(name = "method", value = "survey") |>
    setIDVar(name = "crop", columns = 1) |>
    setObsVar(name = "number_heads", columns = .find(fun = is.numeric, row = 2, relative = TRUE))

  regTable(ADM0 = !!thisNation,
           label = "ADM2",
           subset = paste0("livestock", ADM1Val),
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_livestock,
           begin = 2008,
           end = 2023,
           archive = thisFile,
           archiveLink = paste0("https://www.gks.ru/dbscripts/munst/munst", munst, "/DBInet.cgi"),
           updateFrequency = "annually",
           downloadDate = dmy("05-02-2025"),
           metadataLink = "unknown",
           metadataPath = "unknown",
           overwrite = TRUE)

}

normTable(pattern = paste0("livestock.*", ds[1]),
          ontoMatch = "animal",
          beep = 10)


## machines ----
rosstat_machine <- list.files(path = paste0(.get_path("cens", "_data"), "/tables/stage1/rosstat/"),
                              pattern = "machine")

for(i in seq_along(rosstat_machine)){

  thisFile <- rosstat_machine[i]
  name <- str_split(thisFile, "_")[[1]]
  munst <- name[2]
  ADM1Val <- str_split(name[1], "[.]")[[1]][1]

  schema_machine <-
    setCluster(id = "ADM2", left = 1, top = .find(pattern = "значение за год|значение показателя за год", col = 1)) |>
    setFilter(rows = .find(pattern = paste0(locNames, "штука"), col = 1, invert = TRUE), clusters = FALSE) |>
    setIDVar(name = "ADM1", value = ADM1Val) |>
    setIDVar(name = "ADM2", columns = 1, split = "(?<=делением\\, ).*|(?<=значение за год\\, Муниципальный район\\, ).*", rows = .find(row = 1, relative = TRUE)) |>
    setIDVar(name = "year", columns = .find(fun = is.numeric, row = 2, relative = TRUE), rows = .find(row = 2, relative = TRUE)) |>
    setIDVar(name = "method", value = "survey") |>
    setIDVar(name = "machine", columns = 1) |>
    setObsVar(name = "number_machines", columns = .find(fun = is.numeric, row = 2, relative = TRUE))

  regTable(ADM0 = !!thisNation,
           label = "ADM2",
           subset = paste0("machine", ADM1Val),
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_machine,
           begin = 2008,
           end = 2023,
           archive = thisFile,
           archiveLink = paste0("https://www.gks.ru/dbscripts/munst/munst", munst, "/DBInet.cgi"),
           updateFrequency = "annually",
           downloadDate = dmy("05-02-2025"),
           metadataLink = "unknown",
           metadataPath = "unknown",
           overwrite = TRUE)

}

normTable(pattern = paste0("machine.*", ds[1]),
          ontoMatch = "tech",
          beep = 10)


## mineral fertilizer ----
rosstat_fertMin <- list.files(path = paste0(.get_path("cens", "_data"), "/tables/stage1/rosstat/"),
                              pattern = "fertMin")

for(i in seq_along(rosstat_fertMin)){

  thisFile <- rosstat_fertMin[i]
  name <- str_split(thisFile, "_")[[1]]
  munst <- name[2]
  ADM1Val <- str_split(name[1], "[.]")[[1]][1]

  schema_fertMin <-
    setCluster(id = "ADM2", left = 1, top = .find(pattern = "значение за год|значение показателя за год", col = 1)) |>
    setFilter(rows = .find(pattern = "центнер", col = 1, invert = TRUE), clusters = FALSE) |>
    setIDVar(name = "ADM1", value = ADM1Val) |>
    setIDVar(name = "ADM2", columns = 1, split = "(?<=делением\\, ).*|(?<=значение за год\\, Муниципальный район\\, ).*|(?<=значение показателя за год\\, Муниципальный район\\, ).*", rows = .find(row = 1, relative = TRUE)) |>
    setIDVar(name = "year", columns = .find(fun = is.numeric, row = 2, relative = TRUE), rows = .find(row = 2, relative = TRUE)) |>
    setIDVar(name = "method", value = "survey") |>
    setIDVar(name = "fertilizer", value = "Внесение минеральных удобрений (в пересчете на 100% питательных веществ) под посевы сельскохозяйственных культур в сельскохозяйственных организациях") |>
    setObsVar(name = "centner_mineral", columns = .find(fun = is.numeric, row = 2, relative = TRUE))

  regTable(ADM0 = !!thisNation,
           label = "ADM2",
           subset = paste0("fertMin", ADM1Val),
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_fertMin,
           begin = 2008,
           end = 2023,
           archive = thisFile,
           archiveLink = paste0("https://www.gks.ru/dbscripts/munst/munst", munst, "/DBInet.cgi"),
           updateFrequency = "annually",
           downloadDate = dmy("05-02-2025"),
           metadataLink = "unknown",
           metadataPath = "unknown",
           overwrite = TRUE)

}

normTable(pattern = paste0("fertMin.*", ds[1]),
          ontoMatch = "tech",
          beep = 10)


## organic fertilizer ----
rosstat_fertOrg <- list.files(path = paste0(.get_path("cens", "_data"), "/tables/stage1/rosstat/"),
                              pattern = "fertOrg")

for(i in seq_along(rosstat_fertOrg)){

  thisFile <- rosstat_fertOrg[i]
  name <- str_split(thisFile, "_")[[1]]
  munst <- name[2]
  ADM1Val <- str_split(name[1], "[.]")[[1]][1]

  schema_fertOrg <-
    setCluster(id = "ADM2", left = 1, top = .find(pattern = "значение за год|значение показателя за год", col = 1)) |>
    setFilter(rows = .find(pattern = "тонна", col = 1, invert = TRUE), clusters = FALSE) |>
    setIDVar(name = "ADM1", value = ADM1Val) |>
    setIDVar(name = "ADM2", columns = 1, split = "(?<=делением\\, ).*|(?<=значение за год\\, Муниципальный район\\, ).*|(?<=значение показателя за год\\, Муниципальный район\\, ).*", rows = .find(row = 1, relative = TRUE)) |>
    setIDVar(name = "year", columns = .find(fun = is.numeric, row = 2, relative = TRUE), rows = .find(row = 2, relative = TRUE)) |>
    setIDVar(name = "method", value = "survey") |>
    setIDVar(name = "fertilizer", value = "Внесено органических удобрений под посевы сельскохозяйственных культур в сельскохозяйственных организациях") |>
    setObsVar(name = "centner_organic", factor = 10, columns = .find(fun = is.numeric, row = 2, relative = TRUE))

  regTable(ADM0 = !!thisNation,
           label = "ADM2",
           subset = paste0("fertOrg", ADM1Val),
           dSeries = ds[1],
           gSeries = gs[1],
           schema = schema_fertOrg,
           begin = 2008,
           end = 2023,
           archive = thisFile,
           archiveLink = paste0("https://www.gks.ru/dbscripts/munst/munst", munst, "/DBInet.cgi"),
           updateFrequency = "annually",
           downloadDate = dmy("05-02-2025"),
           metadataLink = "unknown",
           metadataPath = "unknown",
           overwrite = TRUE)

}

normTable(pattern = paste0("fertOrg.*", ds[1]),
          ontoMatch = "tech",
          beep = 10)

