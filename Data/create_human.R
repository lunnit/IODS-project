#Data wrangling

#installing libraries

library(readr)
library(dplyr)

#2 
#read the data

hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")


#3
#summaries etc. 
str(hd)
dim(hd)

str(gii)
dim(gii)

summary(hd)
summary(gii)


#4
#renaming the variables

#hd variables
hd<-rename (hd, "HDI" = "Human Development Index (HDI)") 
hd<-rename (hd, "Life.Exp" = "Life Expectancy at Birth") 
hd<-rename (hd, "Edu.Exp" = "Expected Years of Education") 
hd<-rename (hd, "GNI" = "Gross National Income (GNI) per Capita") 

#gii variables
gii<-rename(gii,"Mat.Mor" = "Maternal Mortality Ratio")
gii<-rename(gii,"Ado.Birth" = "Adolescent Birth Rate")
gii<-rename(gii,"Parli.F" = "Percent Representation in Parliament")
gii<-rename(gii,"Edu2.F" = "Population with Secondary Education (Female)")
gii<-rename(gii,"Edu2.M" = "Population with Secondary Education (Male)")
gii<-rename(gii,"Labo.F" = "Labour Force Participation Rate (Female)")
gii<-rename(gii,"Labo.M" = "Labour Force Participation Rate (Male)")

#5
#creating the new variables

gii<-gii %>%
  mutate (Edu2.FM = (Edu2.F / Edu2.M))

gii<-gii %>%
  mutate (Labo.FM = (Labo.F / Labo.M))

#6
#joining the data sets
human <-inner_join(gii, hd, by= "Country")

write_csv (x=human, "Z:/IODS/IODS-project/Data/human.csv")
