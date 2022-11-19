#Assignment 3:Data wrangling
#Kaisa Elovaara
#17.11.2022
#R-script to combine two Student Performance data sets by  UCI Machine Learning Repository

#installing required libraries
# install.packages("boot")
# install.packages("readr")
library(boot)
library(readr)
library(dplyr)
library(ggplot2)
library(readr)

# 3. 
#reading the data

getwd()
#if not correct
#setwd("*insert path here*")

math <- read.csv("Data/student-mat.csv", 
                    sep=";", header=TRUE)
por <- read.csv("Data/student-por.csv", 
                   sep=";", header=TRUE)

#Exploring the structure and dimensions
dim(math)
str(math)

dim(por)
str(por)

#4.
#joining the data sets
free_cols <- c("failures","paid","absences","G1","G2","G3")
join_cols <- setdiff(colnames(por), free_cols)
math_por <- inner_join(math, por, by = join_cols, suffix = c(".math", ".por"))

#filter here?

dim(math_por)
str(math_por)
glimpse(math_por)

#5.
#getting rid of the duplicates
alc <- select(math_por, all_of(join_cols))
for(col_name in free_cols) {
  two_cols <- select(math_por, starts_with(col_name))
  first_col <- select(two_cols, 1)[[1]]

  if(is.numeric(first_col)) {
    alc[col_name] <- round(rowMeans(two_cols))
  } else { 
    alc[col_name] <- first_col
  }
}

#6. 
#creating new columns 

alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)
alc <- mutate(alc, high_use = alc_use > 2)

#7
#save the data
glimpse (alc)

write_csv (x=alc, "Z:/IODS/IODS-project/Data/alc.csv")


