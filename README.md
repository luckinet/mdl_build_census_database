# mdl_buid_census_database

## Rationale

This module has the purpose of building a harmonized database of census statistics on land use, forestry and agricultural commodities (crops and livestock). Basic data are sourced from the FAO and more detailed data are taken from open sources such as national or pan-regional statistical agencies (databases and yearbooks) or other collation efforts that produce sub-national census datasets (such as [countryStat](https://www.fao.org/in-action/countrystat/en/), [FAO Data Lab](https://www.fao.org/datalab/en)).


## The input data


## Methods

### Meta data

The module-specific meta data capture ...

```
# ----
# geography   : Brazil
# spatial     : Nation, Estado, Municipality
# period      : (1974)1990 - 2022
# variables   :
# - land      : hectares_covered
# - crops     : hectares_planted, hectares_harvested, tons_produced, kiloPerHectare_yield
# - livestock : number_heads
# - tech      : -
# - social    : -
# sampling    : survey, census
# ----
```

### Tools


## The output

## Change-Log

Please find a documentation of recent changes [here](LOG.md).


## Acknowledgements


### other snippets

Scripts (in the folder '/src') are organised either per data-series (such as fao, countrystat or eurostat) or per nation. Each script follows a clearly defined template, where

1) the meta-data are recorded,
2) geometries (if available) and data tables are recorded and
3) geometries (if available) and data tables are normalized (whereby territory names are matched with the gazetteer, commodities/land-use concepts are matched with the LUCKINet land-use ontology and tables are translated to a common standard via `tabshiftr`).


After collecting all information in a harmonized database some further steps are required. The final script `99_make_database.R` carries these out:

- summarize values per territorial unit, in case they were double reported or when external concepts had to be harmonized so that several external concepts refer to the same harmonized concept.
- optionally interpolate missing values (depending on the model run)
- carry out checks that ensure the patterns are within reasonable bounds.
- determine quality flags for provenance documentation.


## Database structure

Each script produces an `*.rds`-file that contains a data-frame of the harmonized data tables and a geopackage (`*.gpkg`) file of the geometry associated to those data (typically based on GADM). Each harmonized table then contains the following columns:

| name       | type      | description                                                                                                                                                                                              |
|:---------- |:--------- |:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| tabID      | integer   | the identifier of the specific table (see `inv_tables.csv`) from which the observation originates                                                                                                        |
| geoID      | integer   | the identifier of the specific geometry data-series to which the observation is associated/where it occurs                                                                                               |
| gazID      | integer   | the administrative hierarchy identifier                                                                                                                                                                  |
| gazName    | character | the (hierarchical) name of the territorial unit. This is a combination of all the parents up to the territory in question                                                                                |
| gazMatch   | character | the match between the harmonized territorial unit and the external territorial unit                                                                                                                                                                                                         |
| year       | YYYY      | the year in which the census observation has been recorded                                                                                                                                               |
| ontoID     | character | the identifier of the land use concept                                                                                                                                                   |
| ontoName   | character | the (hierarchical) name of the land use concept                                                                                                                                                          |
| ontoMatch|  character  |        the match between the harmonized land use concept and the external land use concept                                                                                                                                                                                                  |
| harvested  | numeric   | the area that was harvested [hectare] (for agricultural commodities only)                                                                                                                                |
| planted    | numeric   | the area that was planted [hectare] (for agricultural commodities only)                                                                                                                                  |
| area       | numeric   | either the area of landcover or land use or in case an agricultural commodity is quantified only in coarse detail without specification of whether it is measured by harvested or planted area [hectare] |
| production | numeric   | the production quantity [tonnes] (for agricultural commodities only)                                                                                                                                     |
| yield      | numeric   | the yield [production per harvested area] (for agricultural commodities only)                                                                                                                            |
| headcount  | numeric   | the number of animals (for livestock only)                                                                                                                                                               |
| ...        | numeric   | possibly other variables that are also reported and which may give some indication of or hint at the above variables                                                                                     |

Each geometry contains a layer per territorial level with an associated attribute table that has the following columns:

| name     | type      | description                                                                                                               |
| :------- | :-------- | :------------------------------------------------------------------------------------------------------------------------ |
| fid      | integer   | territorial unit identifier                                                                                               |
| gazID    | integer   | the administrative hierarchy identifier                                                                                   |
| gazName  | character | the (hierarchical) name of the territorial unit. This is a combination of all the parents up to the territory in question |
| gazClass | numeric   | the class to which the territorial units are associated in the gazetteer                                                  |
| match    | character | the match of the harmonised and the external territorial concept                                                          |
| external | character | the (hierarchical) name of the external territorial unit                                                                  |
| geoID    | integer   | the identifier of the geometry dataseries from which the territory originates                                             |
| geom     | geometry  | the geometric information of the territorial unit (simple features standard)                                              |


## script structure
