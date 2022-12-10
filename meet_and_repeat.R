
#libraries 
library(dplyr)
library(tidyr)

#1. 
#getting the data
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep =" ", header = T)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')

write.table (x=BPRS, "Z:/IODS/IODS-project/Data/BPRS.txt")
write.table (x=RATS, "Z:/IODS/IODS-project/Data/RATS.txt")

names(BPRS)
str(BPRS)
summary(BPRS)

names(RATS)
str(RATS)
summary(RATS)


#2.

BPRS$subject <- factor(BPRS$subject)
BPRS$treatment <- factor(BPRS$treatment)

RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

#3.

#BPRS

# Convert to long form
BPRSL <-  pivot_longer(BPRS, cols = -c(treatment, subject),
                       names_to = "weeks", values_to = "bprs") %>%
  arrange(weeks) #order by weeks variable
BPRSL <-  BPRSL %>% 
  mutate(week = as.integer(substr(weeks,5,5)))

#RATS

# Convert data to long form
RATSL <- pivot_longer(RATS, cols = -c(ID, Group), 
                      names_to = "WD",
                      values_to = "Weight") %>% 
  mutate(Time = as.integer(substr(WD, 3,4))) %>%
  arrange(Time)  
         
write.table (x=BPRSL, "Z:/IODS/IODS-project/Data/BPRSL.txt")
write.table (x=RATSL, "Z:/IODS/IODS-project/Data/RATSL.txt")

#4.
         
names (BPRSL)
names(BPRS)
str(BPRSL)
str(BPRS)

glimpse(BPRSL)
glimpse((BPRS))

summary(BPRSL)
summary(BPRS)

names(RATSL)
names(RATS)
str(RATSL)
str(RATS)

glimpse (RATSL)
glimpse(RATS)

summary(RATSL)
summary(RATS)

#instead of being several variables, point in time and value measured then  
#are no two variables: time and value
#there are then less variables but more observations as variables are kind of turned into observations