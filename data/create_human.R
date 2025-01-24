# Chamalee Wickrama Arachchi
# 26-11-2021
# Data wrangling file.
# Data url: http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv ,
# http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv

# read the data into memory
setwd("/Users/chamwick/Documents/ODS-R/project/IODS-project")

hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# math <- read.table("data/student-mat.csv", sep = ";" , header=TRUE)
# por <- read.table("data/student-por.csv", sep = ";" , header=TRUE)

# Look at the dimensions of the data
dim(hd)
dim(gii)

# Look at the structure of the data
str(hd)
str(gii)

# > str(hd)
# 'data.frame':	195 obs. of  8 variables:
#   $ HDI.Rank                              : int  1 2 3 4 5 6 6 8 9 9 ...
# $ Country                               : chr  "Norway" "Australia" "Switzerland" "Denmark" ...
# $ Human.Development.Index..HDI.         : num  0.944 0.935 0.93 0.923 0.922 0.916 0.916 0.915 0.913 0.913 ...
# $ Life.Expectancy.at.Birth              : num  81.6 82.4 83 80.2 81.6 80.9 80.9 79.1 82 81.8 ...
# $ Expected.Years.of.Education           : num  17.5 20.2 15.8 18.7 17.9 16.5 18.6 16.5 15.9 19.2 ...
# $ Mean.Years.of.Education               : num  12.6 13 12.8 12.7 11.9 13.1 12.2 12.9 13 12.5 ...
# $ Gross.National.Income..GNI..per.Capita: chr  "64,992" "42,261" "56,431" "44,025" ...
# $ GNI.per.Capita.Rank.Minus.HDI.Rank    : int  5 17 6 11 9 11 16 3 11 23 ...
# > str(gii)
# 'data.frame':	195 obs. of  10 variables:
#   $ GII.Rank                                    : int  1 2 3 4 5 6 6 8 9 9 ...
# $ Country                                     : chr  "Norway" "Australia" "Switzerland" "Denmark" ...
# $ Gender.Inequality.Index..GII.               : num  0.067 0.11 0.028 0.048 0.062 0.041 0.113 0.28 0.129 0.157 ...
# $ Maternal.Mortality.Ratio                    : int  4 6 6 5 6 7 9 28 11 8 ...
# $ Adolescent.Birth.Rate                       : num  7.8 12.1 1.9 5.1 6.2 3.8 8.2 31 14.5 25.3 ...
# $ Percent.Representation.in.Parliament        : num  39.6 30.5 28.5 38 36.9 36.9 19.9 19.4 28.2 31.4 ...
# $ Population.with.Secondary.Education..Female.: num  97.4 94.3 95 95.5 87.7 96.3 80.5 95.1 100 95 ...
# $ Population.with.Secondary.Education..Male.  : num  96.7 94.6 96.6 96.6 90.5 97 78.6 94.8 100 95.3 ...
# $ Labour.Force.Participation.Rate..Female.    : num  61.2 58.8 61.8 58.7 58.5 53.6 53.1 56.3 61.6 62 ...
# $ Labour.Force.Participation.Rate..Male.      : num  68.7 71.8 74.9 66.4 70.6 66.4 68.1 68.9 71 73.8 ...

# Look at the summary of the data
summary(hd)
summary(gii)

# rename the variables with (shorter) descriptive names
hdcols <- colnames(hd) %>%
  cbind(c("HDIrank","Country","HDI","LEaB","EYoE","MYoE","GNIpC","GNI_HDIrank")) %>%
  as.data.frame()
colnames(hdcols) <- c("Old","New")

# Access the dplyr library
# library(dplyr)
# dplyr::rename(hd, c("HDIrank","Country","HDI","LEaB","EYoE","MYoE","GNIpC","GNI_HDIrank"))

giicols <- colnames(gii) %>%
  cbind(c("GIIrank","Country","gii","MMR","ABR","PRiP","edu2F","edu2M","labF","labM")) %>%
  as.data.frame()              
colnames(giicols) <- c("Old","New")

# change the column names

colnames(hd) <- hdcols$New
colnames(gii) <- giicols$New

# # glimpse new data
glimpse(hd)
glimpse(gii)

# Mutate the “Gender inequality” data and create two new variables. 
# 1. the ratio of Female and Male populations with secondary education in each country. (i.e. edu2F / edu2M). The second new variable should be the ratio of labour force participation of females and males in each country (i.e. labF / labM). 
# 2. the ratio of labour force participation of females and males in each country (i.e. labF / labM)
gii <- gii %>%
  mutate(edu2Ratio = edu2F/edu2M, labRatio = labF/labM)

# Join together the two datasets using the variable Country as the identifier. 
human <- inner_join(hd, gii, by = "Country")

# write data to a csv-file
write.table(human, "data/human.csv", sep = ";", row.names = F, col.names = T)

# Exercise 5 starting from here
# Data wrangling 

# read the human data from URL
human <- read.table("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt", sep  =",", header = T)

#load the human data
# human <- read.table("data/human.csv", sep = ";")

#examine the structure and dimensions of the data
## 195 observations of 19 variables
str(human)
dim(human)

# transform the Gross National Income (GNI) variable to numeric

library(stringr) 

# look at the structure of the GNI column in 'human'
str(human$GNI)

# 1. remove the commas from GNI and print out a numeric version of it
str_replace(human$GNI, pattern=",", replace ="") %>% as.numeric

# 2. Filter the variables 

# columns to keep
keep <- c("Country", "Edu2.FM", "Labo.FM", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")

# select the 'keep' columns
human <- select(human, one_of(keep))

# print out a completeness indicator of the 'human' data
complete.cases(human)

# print out the data along with a completeness indicator as the last column
data.frame(human[-1], comp = complete.cases(human))

# 3. filter out all rows with NA values
human <- filter(human, complete.cases(human))


# last indice we want to keep, last 7 are  regions than  countries
last <- nrow(human) - 7

# 4. choose everything until the last 7 observations
human <- human[1:last, ]

# 5. add countries as rownames
rownames(human) <- human$Country
# remove the Country variable
human <- select(human, -Country)

# save the data to file
write.table(human, "data/human.csv", sep = ";")






