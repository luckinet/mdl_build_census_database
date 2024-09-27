
# 1. Rationale

About the writing, the most important is provide a table with all links and name of national agencies where you did download the census data + explain the genera workflow implemented (citing your packages, etc). Can you start working on that this week?! I think you have everything set for it, right?


# 2. Method

The census database is built with the R packages `arealDB` for organizing the database and `tabshiftr` for reorganizing messy tables. The spatial basis is the GADM data-set (<https://gadm.org/index.html>) or, if available, geometries provided by the national statistical agencies. Agricultural commodity and land-use terms are taken from the LUCKINet land-use ontology.

The variables in the focus of LUCKINet are those variables that are already harmonized by the FAO:

1) the area covered by land use (largely hamonized from the CORINE Land-Cover dataproduct),
2) the area covered by various types of forests as defined in the FAO Forest Resource Assessment.
3) the planted and harvested area and the production of all agricultural commodities that are grown in any region, which may include various data about grazing or pastures and also fallow land, even though they are often instead reported as "land use" statistics.
The dataset of agricultural commodity and land-use census data is the central element of the [[_loca|loca]] workflow, because it serves to allocate correct areas into administrative territories and helps training suitability models.

# 3. Files



# 4. Version changes

none so far, this is the initial release.

# 5. Acknowledgements

