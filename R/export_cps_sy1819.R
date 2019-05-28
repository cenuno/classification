#
# Author:   Cristian E. Nuno
# Purpose:  Export .rda file to a .csv file
# Date:     May 27, 2019
#

# load necessary package ----
library(readr)
library(pointdexter)

# load necessary data ----
data("cps_sy1819")

# export data as csv ----
write_csv(cps_sy1819, "~/Python_All/classification/raw_data/cps_sy1819_profiles.csv")

# end of script #
