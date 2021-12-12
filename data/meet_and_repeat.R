# Chamalee Wickrama Arachchi
# 03-12-2021
# Data wrangling file.
# Data url: https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt ,
#https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt

# read the data into memory
setwd("/Users/chamwick/Documents/ODS-R/project/IODS-project")

# We will dwelve in to the BPRS data, in which 40 male subjects were randomly assigned to one of two treatment groups and
# each subject was rated on the brief psychiatric rating scale (BPRS) measured before treatment began (week 0) and then at weekly intervals
# for eight weeks. The BPRS assesses the level of 18 symptom constructs such as hostility, suspiciousness, hallucinations and grandiosity;
# each of these is rated from one (not present) to seven (extremely severe). The scale is used to evaluate patients suspected of having 
# schizophrenia.

# Read the BPRS data
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)

# Look at the (column) names of BPRS
names(BPRS)

# Look at the structure of BPRS
str(BPRS)
dim(BPRS)

# print out summaries of the variables
summary(BPRS)

write.csv(BPRS, "data/BPRSW.csv", row.names = FALSE)


################################################################################

# Read the BPRS data
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", sep  ="\t", header = T)

# Look at the (column) names of RATS
names(RATS)

# Look at the structure of RATS
str(RATS)

# print out summaries of the variables
summary(RATS)

write.csv(RATS, "data/RATSW.csv", row.names = FALSE)
################################################################################

library(dplyr) 
library(tidyr)

# Factor treatment & subject
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

# Convert to long form
BPRS_L <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)

# Extract the week number
BPRS_L <-  BPRS_L %>% mutate(week = as.integer(substr(weeks,5,5)))

# Convert to long form
RATS_L = RATS %>% gather(key = WD, value = Weight, -ID, -Group) 

# Extract the WD number
RATS_L <-  RATS_L%>% mutate(Time = as.integer(substr(WD,3,4))) 

################################################################################

# Look at the difference between WIDE and LONG sets

glimpse(BPRS)
glimpse(BPRS_L)

glimpse(RATS)
glimpse(RATS_L)


str(BPRS)
str(BPRS_L)

str(RATS)
str(RATS_L)


summary(BPRS)
summary(BPRS_L)

summary(RATS)
summary(RATS_L)

################################################################################

write.csv(BPRS_L, "data/BPRSL.csv", row.names = FALSE)
write.csv(RATS_L, "data/RATSL.csv", row.names = FALSE)

################################################################################






