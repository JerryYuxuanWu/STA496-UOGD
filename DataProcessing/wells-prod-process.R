###############################################
# This file takes in the downloaded well production data from Enverus and
# well header data, which is processed in _____ and finds the common wells
# It exports the production of data of the wells present in the header csv
#
# This file filters for production data since 2010
#
# Input: PBWellProd2016- Well Monthly Production.CSV
#        carlsbad_prod Well Monthly Production.CSV (Old)
#        Carlsbad Well Prod 0923 Well Monthly Production.CSV (New)
#        cleaned_wells_pb.rds
#        cleaned_wells_cb.rds
#
# Output: pb_wells_prod.rds, cb_wells_prod.rds
#
###############################################
library(tidyverse)

#-----------For Carlsbad Prod Data---------#
wells_prod <- read_csv('../data/wells/Carlsbad 80km radius wells Well Monthly Production.CSV', 
                       col_select = c(`API/UWI`, `Monthly Production Date`,
                                      `Monthly Oil`, `Monthly Gas`, `Well Status`, `Production Type`))

cb_wells <- readRDS('../data/wells/cleaned_wells_cb.rds')

wells_prod_clean <- wells_prod %>%
  filter(!(`Monthly Production Date` < '2010-01-01'))

# Find difference in well data
#print(setdiff(wells_prod_clean$`API/UWI`,cb_wells$API14))
#print(setdiff(cb_wells$API14, wells_prod_clean$`API/UWI`))

cb_wells_prod_inner <- wells_prod_clean %>%
  inner_join(cb_wells, by = c("API/UWI" = "api")) %>%
  rename(api = `API/UWI`, prod_date = `Monthly Production Date`, 
         monthly_oil = `Monthly Oil`, monthly_gas = `Monthly Gas`,
         well_status_p = `Well Status`, prod_type_p = `Production Type`)

saveRDS(
  cb_wells_prod_inner,
  "../data/wells/cb_wells_prod.rds")


