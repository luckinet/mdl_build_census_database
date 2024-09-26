# ----
# title       : build census database
# description : This is the main script for building a database of (national and sub-national) census data for all crop and land-use dimensions of LUCKINet and all livestock dimensions of GPW.
# license     : https://creativecommons.org/licenses/by-sa/4.0/
# authors     : Steffen Ehrmann
# date        : 2024-09-26
# version     : 0.9.0
# status      : working
# comment     : file.edit(paste0(dir_docs, "/documentation/mdl_build_census_database.md"))
# ----

# set module-specific paths ----
#
path_onto <- paste0(.get_path("onto", "_data"), "lucki_onto.rds")
path_gaz <- paste0(.get_path("onto", "_data"), "lucki_gazetteer.rds")


# start database or set path of current build ----
#
adb_init(root = .get_path("cens", "_data"), version = model_info$tag,
         licence = "https://creativecommons.org/licenses/by-sa/4.0/",
         gazetteer = path_gaz, top = "al1",
         ontology = list("crop" = path_onto, "animal" = path_onto, "use" = path_onto),
         author = list(cre = model_info$authors$cre,
                       aut = model_info$authors$aut$census,
                       ctb = model_info$authors$ctb$census))

build_crops <- model_info$domains$crops
build_livestock <- model_info$domains$livestock
build_landuse <- model_info$domains$landuse

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
adb_archive(outPath = .get_path("cens", "_data"), compress = TRUE)
