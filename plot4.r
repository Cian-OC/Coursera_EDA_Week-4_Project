
## Question 4:

## Across the United States, how have emissions from coal combustion-related 
## sources changed from 1999–2008?

## Get tidyverse

install.packages("tidyverse")

library(tidyverse)

library(dplyr)

library(ggplot2)


## Get the data

library(data.table)

path <- getwd()

download.file(url= "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
              , destfile = paste(path, "dataFiles.zip", sep="/"))

unzip(zipfile="dataFiles.zip", exdir=path)

SCC <- data.table::as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))

NEI <- data.table::as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))

## Get combustion and coal data

SCC_list <- SCC %>% 
  dplyr::filter(base::grepl(x = EI.Sector,
                            pattern = "Coal|coal")) %>%
  dplyr::select(SCC, EI.Sector)

NEI_Coal <- base::subset(x = NEI, SCC %in% SCC_list$SCC)

NEI_Coal_v2 <- base::merge(NEI_Coal, SCC_list)

NEI_Coal_v3 <- NEI_Coal_v2 %>%
  dplyr::group_by(year, EI.Sector) %>%                                    
  dplyr::summarise(Total = base::sum(Emissions)) %>%                      
  dplyr::mutate(EI.Sector = base::gsub(pattern = "Fuel Comb - | - Coal",
                                       replacement =  "",
                                       x = EI.Sector))

NEI_Coal_v3_total <- NEI_Coal_v3 %>%
  dplyr::summarise(Total = base::sum(Total)/1000)

## Plot 4

png(filename="plot4.png")
NEI_Coal_v3 %>% 
  ggplot(aes(x=year,
             y=Total/1000,
             fill = EI.Sector))+
  geom_bar(stat = "identity")+
  scale_x_discrete(limits = c(1999, 2002, 2005, 2008)) +
  labs(x= "Year",
       y= "PM"[2.5]~"Emissions(10"^3~"tons)",
       title = "Change in Coal Combustion-Related Sources, 1999-2008")
dev.off()

