# ----
# title       : build census database
# description : This is the main script for building a database of (national and sub-national) census data for all crop and land-use dimensions of LUCKINet and all livestock dimensions of GPW.
# license     : https://creativecommons.org/licenses/by-sa/4.0/
# authors     : Steffen Ehrmann
# date        : 2024-09-26
# version     : 0.7.0
# status      : working
# notes       : file.edit(paste0(dir_docs, "/documentation/mdl_build_census_database.md"))
# ----

# set module-specific paths ----
#
path_onto <- paste0(.get_path("onto", "_data"), "lucki_onto.rds")
path_gaz <- paste0(.get_path("onto", "_data"), "lucki_gazetteer.rds")


# start database or set path of current build ----
#
adb_init(root = .get_path("cens", "_data"), version = model_info$tag,
         licence = "https://creativecommons.org/licenses/by-sa/4.0/",
         gazetteer = path_gaz, top = "ADM0",
         ontology = list("crop" = path_onto, "animal" = path_onto, "use" = path_onto),
         author = list(cre = model_info$authors$cre,
                       aut = model_info$authors$aut$census,
                       ctb = model_info$authors$ctb$census))


# prepare spatial basis ----
#
# (run these only once, when the respective data need to be processed)
source(paste0(.get_path("cens"), "01_setup_gadm.R"))


# build database ----
#
.run_submodules(model = model_info, module = "cens")


# tie everything together ----
#
adb_backup()
adb_archive(outPath = .get_path("cens", "_data"), compress = FALSE)


#### test schemas ----

myRoot <- paste0(.get_path("cens", "_data"), "tables/stage2/")
myFile <- "Russian Federation_ADM2_yieldBelgorod_2008_2023_rosstat.csv"
input <- read_csv(file = paste0(myRoot, myFile),
                  col_names = FALSE,
                  col_types = cols(.default = "c"),
                  trim_ws = FALSE)

schema <-
  setCluster(id = "ADM2", left = 1, top = .find(pattern = "значение за год|значение показателя за год", col = 1)) |>
  setFilter(rows = .find(pattern = paste0(locNames, "центнеров с гектара|центнер с гектара|Центнер с гектара"), col = 1, invert = TRUE), clusters = FALSE) |>
  setIDVar(name = "ADM1", value = ADM1Val) |>
  setIDVar(name = "ADM2", columns = 1, split = "(?<=категорий\\, ).*", rows = .find(row = 1, relative = TRUE)) |>
  setIDVar(name = "year", columns = .find(fun = is.numeric, row = 2, relative = TRUE), rows = .find(row = 2, relative = TRUE)) |>
  setIDVar(name = "method", value = "survey") |>
  setIDVar(name = "crop", columns = 1) |>
  setObsVar(name = "kiloPerHectare_yield", factor = 100, columns = .find(fun = is.numeric, row = 2, relative = TRUE))

schema_test <- schema |>
  validateSchema(input = input)
input_test <- input |>
  validateInput(schema = schema_test)

ids <- schema_test |>
  getIDVars(input = input_test)

obs <- schema_test |>
  getObsVars(input = input_test)

grp <- schema_test |>
  getGroupVar(input = input_test)

clst <- schema_test |>
  getClusterVar(input = input_test)

output <- reorganise(input = input, schema = schema)


adb_visualise(territory = list(al1 = ""),
              concept = list(animal = "cattle"),
              variable = "number_heads",
              level = "ADM2",
              year = 2000:2020,
              animate = TRUE)
