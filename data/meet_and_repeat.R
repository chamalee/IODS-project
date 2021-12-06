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
bprs <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)

# Look at the (column) names of BPRS
names(bprs)

# Look at the structure of BPRS
str(bprs)
dim(bprs)

# print out summaries of the variables
summary(bprs)



################################################################################

# Read the BPRS data
rats <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", sep  =" ", header = T)

# Look at the (column) names of RATS
names(rats)

# Look at the structure of RATS
str(rats)

# print out summaries of the variables
summary(rats)


################################################################################

library(dplyr) 
library(tidyr)













