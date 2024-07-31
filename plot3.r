
## Question 3: 

## Of the four types of sources indicated by the 𝚝𝚢𝚙𝚎 (point, nonpoint, 
## onroad, nonroad) variable, which of these four sources have seen decreases 
## in emissions from 1999–2008 for Baltimore City? Which have seen increases 
## in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot 
## answering this question.

## Get the data

library(data.table)

library(ggplot2)

path <- getwd()

download.file(url= "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
              , destfile = paste(path, "dataFiles.zip", sep="/"))

unzip(zipfile="dataFiles.zip", exdir=path)

SCC <- data.table::as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))

NEI <- data.table::as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))

baltimore <- NEI[NEI$fips=="24510"] ## subset dataframe to just include Baltimore data

png("plot3.png")

ggplot(data=baltimore, aes(x=factor(year),y=Emissions,fill=type)) +
        geom_bar(stat="identity") +
        scale_fill_manual(values=c("#FC9604",
                                   "#0FF3E2",
                                   "#FCF104",
                                   "#FC04C7")) +
        facet_grid(.~type, scales = "free", space = "free") +
        labs(x="Year", y="Total PM_2.5 Emissions (Tons)") +
        labs(title = "Total PM_2.5 Emissions (Tons) by Source Type")
        
dev.off()
