
## Question 1: 

## Have total emissions from PM 2.5 decreased in the United States 
## from 1999 to 2008? Using the base plotting system, make a plot showing the 
## totalemission from all sources for each of the years 1999, 2002, 2005, and 2008.

## Step 1: get the data

library(data.table)

install.packages("RColorBrewer")

library(RColorBrewer)

path <- getwd()

download.file(url= "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
              , destfile = paste(path, "dataFiles.zip", sep="/"))

unzip(zipfile="dataFiles.zip", exdir=path)

SCC <- data.table::as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))

NEI <- data.table::as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))

agg <- aggregate(NEI$Emissions ~NEI$year, NEI, sum)
          
# Step 2: Plot the data

col.pal<- brewer.pal(4, "Set3")

png(filename="plot1.png")

barplot(height=agg$`NEI$Emissions`
        , names.arg = agg$`NEI$year`
        , col = col.pal
        , xlab= "Year"
        , ylab = "Total Emissions PM_2.5 (tons)"
        , main = "Total PM_2.5 Emissions by year (US)"
)

dev.off()

