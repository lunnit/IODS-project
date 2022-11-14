#Kaisa(/lunnit in github) 
#Date 9.11.22 
#This is the first data wrangling exercise

#2
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", 
        sep="\t", header=TRUE)
dim(lrn14)
#dimensions are 183 rows (=observations) & 60 columns (=variables)

str(lrn14)
#the command prints out 3 facts about all of the variables in the data frame
#first is variable name (i.e. attitude)
#second is type of the variable (i.e. "int)
#and lastly the command prints values of the variables (i.e variable Aa: 3,2,4,4....)

#3
library(dplyr)
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")


deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep<- rowMeans(deep_columns)

strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14$stra<- rowMeans(strategic_columns)

surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)

lrn14$attitude <-  lrn14$Attitude / 10

keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")
learning2014 <- select(lrn14, one_of(keep_columns))
str(learning2014)

learning2014 <- filter(learning2014, Points >0)

#4
#checking current wd
getwd()
#if not correct then:
#setwd("Z:/IODS/IODS-project/Data") #"path to your wd"
library(readr)
write_csv (x=learning2014, "Z:/IODS/IODS-project/Data/learning2014.csv")

new <-read_csv("Z:/IODS/IODS-project/Data/learning2014.csv")

head (new)
str(new)






