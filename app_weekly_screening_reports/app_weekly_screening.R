################################################################################
### WEEKLY SCREENING OF INDIVIDUAL LEVEL DATA
################################################################################

# the purpose of this app

# screen the raw data on synology to see whether it looks clean and has no 
# major issues or measurement errors

# clear environment
rm(list=ls())


# libraries
library(shiny);library(readr);library(tidyr);library(dplyr);library(readxl); library(grid)
library(lubridate);library(stringr);library(ggplot2);library(pdftools);library(gridExtra);


# load cleaned recap data locally
redcap = read_csv("/Volumes/FS/_ISPM/CCH/Actual_Project/data/App_Personal_Data_Screening/redcap_data.csv") |>
    dplyr::mutate(starttime = ymd_hms(starttime),
                  endtime   = ymd_hms(endtime),
                  redcap_event_name = substr(redcap_event_name, 13,18))
  
# function for file pathing
source("functions.R")

# load user interface and server
source("app_weekly_screening_reports/ui_weekly_screening.R")
source("app_weekly_screening_reports/server_weekly_screening.R")


# run the app
shinyApp(ui = ui, server = server)


# Notes:
# in redcap: the field workers record the "Participant Visit Log"
# the start variable "pvl_start" indicates the end of an observation period
# -> we need the minimum pvl_end as a start cut of the data
# the end variable "pvl_end" indicates the start of an observation period
# -> we need the maximum pvl_start as an end time

# the redcap_event name indicated in which week the participant observed
# study_visit_week_1_arm_1 = week1




