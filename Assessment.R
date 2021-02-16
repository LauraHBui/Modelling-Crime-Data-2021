#  https://docs.ropensci.org/essurvey/

# install.packages("essurvey")
library(essurvey)
library(tidyverse)

# set_email("laura.bui@manchester.ac.uk")

# 9 round- 2018 data for all countries
nine_round <- import_rounds(9)

# input missing data
nine_round <-
  import_rounds(9) %>%
  recode_missings()

# should say 'Downloading ESS9' if 2018 data

show_countries() #38 countries

Bulgaria <- import_country("Bulgaria", 9)

attributes(UK$crmvct)
