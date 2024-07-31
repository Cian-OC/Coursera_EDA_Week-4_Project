

## Question 5: How have emissions from motor vehicle sources changed from 
## 1999–2008 in Baltimore City?

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

## Need to subset data by motor vehicles in Baltimore only (Type = ON-ROAD)

NEI_Bal_Veh <- base::subset(NEI, NEI$fips=="24510" & NEI$type=="ON-ROAD")

## Get total values for each year

Total_Bal_Veh <- NEI_Bal_Veh %>%
                 dplyr::group_by(year) %>%
                 dplyr::summarise(Total=base::sum(Emissions))

## Plot Data

png(filename="plot5.png")
Total_Bal_Veh %>% 
  ggplot(aes(x=year,
             y=Total,
             fill = Total))+
  geom_bar(stat = "identity")+
  scale_x_discrete(limits = c(1999, 2002, 2005, 2008)) +
  labs(x= "Year",
       y= "Total PM"[2.5]~"Emissions (tons)",
       title = "Change in Motor Vehicle Emissions for Baltimore, 1999-2008")

dev.off()




