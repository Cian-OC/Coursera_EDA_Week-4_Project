
## Question 2:

## Have total emissions from PM2.5 decreased in the Baltimore City, 
## Maryland (𝚏𝚒𝚙𝚜 == "𝟸𝟺𝟻𝟷𝟶") from 1999 to 2008? Use the base plotting 
## system to make a plot answering this question.


## Get the data

library(data.table)

path <- getwd()

download.file(url= "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
              , destfile = paste(path, "dataFiles.zip", sep="/"))

unzip(zipfile="dataFiles.zip", exdir=path)


SCC <- data.table::as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))

NEI <- data.table::as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))

baltimore <- NEI[NEI$fips=="24510"] ## subset dataframe to just include Baltimore data

agg.baltimore <- aggregate(baltimore$Emissions ~baltimore$year, baltimore, sum)

library(RColorBrewer)

col.pal<- brewer.pal(4, "Set3")

png(filename="plot2.png")

barplot(height=agg.baltimore$`baltimore$Emissions`
        , names.arg = agg.baltimore$`baltimore$year`
        , col = col.pal
        , xlab = "Year"
        , ylab = "Total Emissions PM_2.5 (tons)"
        , main = "Total PM_2.5 Emissions by year (Baltimore)"
)

dev.off()