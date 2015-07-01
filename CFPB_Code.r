library(sqldf)
library(repmis)
library(bitops)
library(ggplot2)
library(scales)


#read in the CFPB complaints file from my computer
cfpbfile <- read.csv(file='C:\\Users\\Nipun\\Desktop\\R Projects\\CFPB\\CFPB_Consumer_Complaints.csv',header=TRUE)

#download data from dropbox
#cfpbURL <- paste0("https://www.dropbox.com/s/ybbobfpiymgmlwl/CFPB_Consumer_Complaints.csv")
#cfpbfile <- repmis::source_data(cfpbURL,sep = ",",header = TRUE)
 


#find the number of complaints by product
Product <- sqldf("select Product, count(*) as complaints 
                     from cfpbfile 
                     group by Product
                     order by complaints desc")

#find the number of complaints by state
states <- sqldf("select State, count(*) as complaints 
                     from cfpbfile
                     where state <>''
                     group by State
                     order by complaints desc")

#Complaints by state and product type
states_prod <- sqldf("select State, Product, count(*) as complaints 
                     from cfpbfile
                     where state <>''
                     group by State, Product
                     order by State,complaints desc")

#complaints by time period
#first convert string date to actual date 
cfpbfile$ComplaintDate <- as.Date(cfpbfile$Date.received, format = "%m/%d/%Y")
#cfpbfile$ComplaintDate <- as.Date(cfpbfile$"Date received", format = "%m/%d/%Y")



#Generate the dataset
volume <- sqldf("select ComplaintDate, count(*) as complaints 
                     from cfpbfile
                     group by ComplaintDate
                     order by ComplaintDate")


#Generate graphics for the dataset

#Pie Chart from data frame with Appended Sample Sizes
proddist <- table(cfpbfile$Product)
lbls <- paste(names(proddist))
pie(proddist, labels = lbls, main="Distribution of Complaints by Products",cex=.8)

#Create a bar showing complaints by state
statecounts <- table(cfpbfile$State)
barplot(statecounts, main="Complaints by State", xlab="State")

#Create a stacked bar showing complaints by state and product
counts <- table(cfpbfile$Product,cfpbfile$State)
barplot(counts, main="Distribution by State and Product",
        xlab="State", legend = rownames(counts))

#Create a multiple bar showing complaints by state and product
barplot(counts, main="Distribution by State and Product",
        xlab="State", legend = rownames(counts), beside = TRUE)

#Timeline of the complaints
timeline <- table(cfpbfile$ComplaintDate)
barplot(timeline, main="Complaints Over Time", xlab="ComplaintDate")


ggplot(volume,aes(x=as.Date(ComplaintDate),y=complaints))+
  geom_point()+scale_x_date(breaks=date_breaks('month'),labels=date_format('%m/%y'))


