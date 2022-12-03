#Data wrangling part 1

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






#Data wrangling part 2


library(tidyr)
library(stringr)

#load("Z:/IODS/IODS-project/Data/human.csv")

str(human)
dim(human)

#The dataset deals with measuring the development of countries in other indexes than economic growth. 
#Hence, the dataset has variables that concern education, mortality, and labour force. 
#The descriptions of the variables with short names are below:

#HDI = Human Development Index (HDI) 
#Life.Exp = Life Expectancy at Birth
#Edu.Exp = "Expected Years of Education 
#GNI = Gross National Income (GNI) per Capita 
#Mat.Mor = Maternal Mortality Ratio
#Ado.Birth = Adolescent Birth Rate
#Parli.F = Percent of Female Representation in Parliament
#Edu2.F = Female Population with Secondary Education 
#Edu2.M = Male Population with Secondary Education
#Edu2.FM = the Ratio of Female and Male Population with Secondary Education
#Labo.F = Labour Force Participation Rate (Female)
#Labo.M = Labour Force Participation Rate (Male) 
#Labo.FM = Ratio of Labour Force Participation of Females and Males


#1.
str(human$GNI)

human$GNI <-as.numeric(str_replace(human$GNI, pattern=",", replace =""))

#2. remove unneeded variables

#human <- select(human, "Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F" )

keep <- c("Country", "Edu2.FM", "Labo.FM", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")

human <- select(human, one_of(keep))


#3. remove missing values


comp <-complete.cases(human)

human<- filter(human, comp) 

#4. removing rergions

last <- nrow(human) - 7

human <- human[1:last, ]

#5.adding rownames

rownames(human) <- human$Country

human <- select(human, -Country)

write.csv (x=human, "Z:/IODS/IODS-project/Data/human.csv", row.names=TRUE)
