# Chamalee Wickrama Arachchi
# 11-11-2021
# Data wrangling file.
# Data url: https://www.mv.helsinki.fi/home/kvehkala/JYTmooc/JYTOPKYS3-data.txt

# read the data into memory
lrn14 <- read.table("https://www.mv.helsinki.fi/home/kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

# Look at the dimensions of the data
dim(lrn14)

# Look at the structure of the data
str(lrn14)

#[1] 183 rows  60 columns 

# 'data.frame':	183 obs. of  60 variables:
#   $ Aa      : int  3 2 4 4 3 4 4 3 2 3 ...
# $ Ab      : int  1 2 1 2 2 2 1 1 1 2 ...
# $ Ac      : int  2 2 1 3 2 1 2 2 2 1 ...
# $ Ad      : int  1 2 1 2 1 1 2 1 1 1 ...
# $ Ae      : int  1 1 1 1 2 1 1 1 1 1 ...
# $ Af      : int  1 1 1 1 1 1 1 1 1 2 ...
# $ ST01    : int  4 4 3 3 4 4 5 4 4 4 ...
# $ SU02    : int  2 2 1 3 2 3 2 2 1 2 ...
# $ D03     : int  4 4 4 4 5 5 4 4 5 4 ...
# $ ST04    : int  4 4 4 4 3 4 2 5 5 4 ...
# $ SU05    : int  2 4 2 3 4 3 2 4 2 4 ...
# $ D06     : int  4 2 3 4 4 5 3 3 4 4 ...
# $ D07     : int  4 3 4 4 4 5 4 4 5 4 ...
# $ SU08    : int  3 4 1 2 3 4 4 2 4 2 ...
# ....................

# Access the dplyr library
library(dplyr)

# create column 'attitude' by scaling the column "Attitude"
lrn14$attitude <- lrn14$Attitude/10

# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns related to deep learning and create column 'deep' by averaging
deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)

# select the columns related to surface learning and create column 'surf' by averaging
surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)

# select the columns related to strategic learning and create column 'stra' by averaging
strategic_columns <- select(lrn14,one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)

# choose a handful of columns to keep
keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")

# select the 'keep_columns' to create a new dataset
learning2014 <- select(lrn14,one_of(keep_columns))

# print out the column names of the data
colnames(learning2014)

# change the name of the second column
colnames(learning2014)[2] <- "age"

# change the name of "Points" to "points"
colnames(learning2014)[7] <- "points"

# print out the new column names of the data
colnames(learning2014)

# see the stucture of the new dataset
str(learning2014)

# select rows where points is greater than zero
learning2014 <- filter(learning2014, points > 0 )

write.csv(learning2014,'data/learning2014.csv')
learning14_csv <- read.csv("data/learning2014.csv", header=TRUE)

# Look at the structure of the data
str(learning14_csv)

