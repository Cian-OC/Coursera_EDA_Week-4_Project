## Question 6: Compare emissions from motor vehicle sources in Baltimore City 
## with emissions from motor vehicle sources in Los Angeles County, California 
## (fips == "06037"). Which city has seen greater changes over time in motor 
## vehicle emissions?

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

NEI_Bal_LA <- base::subset(NEI, 
                            NEI$fips %in% c("24510", "06037") & NEI$type=="ON-ROAD")


## Add column for city name and merge data

city<-revalue(NEI_Bal_LA$fips, c("24510"="Baltimore", "06037"="Los Angeles"))

NEI_City<-cbind(NEI_Bal_LA, city)

## get summary emissions for both cities

Total_City <- NEI_City %>%
  dplyr::group_by(year, city) %>%
  dplyr::summarise(Total=base::sum(Emissions))

png(filename="plot6.png", height=480, width=800)
Total_City %>% 
          ggplot(aes(x=year,
                     y=Total,
                     fill=city))+
          geom_bar(stat="identity", position=position_dodge())+
          scale_x_discrete(limits = c(1999, 2002, 2005, 2008)) +
          labs(x= "Year",
               y= "Total PM"[2.5]~" Emissions (tons)",
               title="Total Vehicular PM"[2.5]~" Emissions (tons) for Baltimore, MD, and Los Angeles, CA")+
          theme(legend.position = "bottom",
                legend.title=element_blank())
dev.off()
