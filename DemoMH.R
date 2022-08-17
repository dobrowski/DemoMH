


library(MCOE)
library(tidyverse)
library(googlesheets4)


con <- mcoe_sql_con()

schools <- c("Monte Bella", 
             "Martin Luther King", 
             "Sanchez", 
             "Creekside Elementary",
             "La Gloria",
             "Chalone Peaks",
             "Boronda Meadows", 
             "Sherwood Elementary",
             "Everett Alvarez High",
             "Harden Middle", 
             "Soledad High")

schools.list <- paste(schools, collapse = "|")

sheet <- "https://docs.google.com/spreadsheets/d/17LPpZJWHoEkzPN84T5dkq9X8aWWe9UKsCRdYjeGKFdI/edit#gid=0"
    
upc <- tbl(con, "UPC") %>% 
    filter(county_name == "Monterey",
           #        DistrictCode == "10272",
           academic_year == "2021-2022"
    ) %>%
    #     head(20) %>%
    collect()

upc.fil <- upc %>%
    filter(str_detect(school_name,schools.list)) %>%
    filter(!str_detect(district_name, "Peninsula") ) %>%
    select(academic_year, district_name, school_name, total_enrollment:calpads_unduplicated_pupil_count_upc)


sheet_write(ss = sheet,
        #    sheet = "District Enrollment",
            data = upc.fil )
