# 2025-02-15 - v0.8.2 (alpha version)

- I re-ran the whole pipeline while fixing remaining issues in the data and double-checking every produced dataset (the current verison includes FAOstat, eurostat, agriwanet, Argentina, Australia, Bolivia, Brazil, Canada, Chile, China, Colombia, India, Indonesia, Mexico, New Zealand Norway, Paraguay, Peru, Russia, Ukraine, United States of America),
- I revised the module structure so that it's fully self-contained (i.e., does not depend on other scripts/modules of the loca pipeline),
- I simplified the data-series specific scripts so they are a bit more intuitive,
- I revised the documentation ([README.md](README.md))

# 2025-01-28

- scripts for Mexico, Bolivia, Colombia, Peru, Paraguay, Chile and Ukraine

# 2025-01-14 - v0.8.1

- starting to include remaining south american countries

# 2024-10-16 - v0.7.0

- had to fix bugs in arealDB
- scripts were harmonized further
- for the below mentioned regions livestock data were finalized
- more documentation has been written 

# 2024-04-03

- include header into all files and do some database-work

# 2024-03-27

- general housekeeping
- since the last time much work has happened to record livestock data for the GPW project
- currently the big countries/regions are included and on their way to be finalized (Europe, USA, Canada, Brazil, Argentina, Russia, India, China, Australia, New Zealand, countrystat)

# 2023-08-24

- include both LUCKINet and GPW in this repository.
- build a switch that can be used to build either of the projects separately
- sort in code from GPW into the respective countries
- continue harmonising scripts

# 2023-07-26

- revise scripts for usa, ukraine, russia, india, china, canada, new zealand and australia (inlc. usda_preprocess, ukrstat_preprocess, rosstat_preprocess and cnki_preprocess) with regard to the formal requirements and their content (i.e., that they contain the correct data and paths) and that all agCensus and spam data are sorted in to "oldCode.R"
- revise scripts for all other nations with regard to the formal requirements and that all agCensus and spam data are sorted in to "oldCode.R"

# 2023-07-25

- renamed all files that have not been finalized (i.e., all code is formally correct and runs without errors) with a "_" at their beginning.

# 2023-07-13 - prioritizing

- made the file '_misc/prioritize.R' to identify, based on FAO data, which countries are the most-producing countries to prioritize the further work according to that
