###############################################
# This file takes in the downloaded well header data from Enverus and cleans it
# It filters for last production date, keeping wells that produced anytime after given year
# Also filters for production type being gas, oil, oil & gas, and 
# drill type being directional, horizontal, and vertical. 
# These filters match the ones selected on Enverus
#
# Note the input data sets are raw from Enverus, but renamed to well_pb, well_cb, well_ef
#
# Output are stored as cleaned_wells_xx.rds
# Note the rds is to reduce size and allow for GitHub collaboration
#
###############################################
library(tidyverse)

wells_cb <- read_csv('../data/wells/Carlsbad 80km radius wells Well Headers.csv')

# When downloading from enverus, we used the filters:
# 1. Drill type in D, H, V
# 2. Production type in Oil, Gas, Oil & Gas
# 3. Last production date between 2010-01-01 to current (2025-07-01)
# 4. Square box with sides of 160km around the trailer

# Same for Carlsbad
cleaned_wells_cb <- wells_cb %>%
  dplyr::select(api = API14, drill_type = `Drill Type`, spud_date = `Spud Date`, 
                completion_date = `Completion Date`, 
                first_prod_date = `First Prod Date`, 
                last_prod_date = `Last Prod Date`, 
                well_status = `Well Status`, 
                production_type = `Production Type`,
                uog_lon = `Surface Hole Longitude (WGS84)`, 
                uog_lat = `Surface Hole Latitude (WGS84)`,
                Operator.Company.Name = `Operator Company Name`)%>%
  filter(!((last_prod_date < "2010-01-01")), 
         production_type %in% c('GAS', 'OIL', 'OIL & GAS'),
         drill_type %in% c('D', 'H', 'V')) 


# OUTPUT final
saveRDS(cleaned_wells_cb, "../data/wells/cleaned_wells_cb.rds")

