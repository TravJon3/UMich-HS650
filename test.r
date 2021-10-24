library(tm)
library(stringi)
con2019Q1 <- url("http://kevinwurn.github.io/UMich-HS650/final_project_files/2019Q1HealthReformMonitoringSurvey-da37922.0001.rda")
load(con2019Q1)
close(con2019Q1)
con2019Q3 <- url("http://kevinwurn.github.io/UMich-HS650/final_project_files/2019Q3HealthReformMonitoringSurvey-da37630.0001.rda")
load(con2019Q3)
close(con2019Q3)

#rename dataframes
df2019Q1 <- da37922.0001
df2019Q3 <- da37630.0001

#add year/quarter stamps - change RID 
df2019Q1$year <- 2019
df2019Q1$quarter <- 0
df2019Q1$quarter <- as.factor(df2019Q1$quarter)
df2019Q1$RID <- paste0("A", df2019Q1$RID)

df2019Q3$year <- 2019
df2019Q3$quarter <- 1
df2019Q3$quarter <- as.factor(df2019Q3$quarter)
df2019Q3$RID <- paste0("B", df2019Q3$RID)

#merge the two dataframes
colnames2019Q1 <- names(df2019Q1)
colnames2019Q3 <- names(df2019Q3)

removenames2019Q1 <- removeWords(colnames2019Q1,colnames2019Q3)
colnames2019Q1 <- removeWords(colnames2019Q1, removenames2019Q1)

removenames2019Q3 <- removeWords(colnames2019Q3,colnames2019Q1)
colnames2019Q3 <- removeWords(colnames2019Q3, removenames2019Q3)

colnamesInnerJoin <- stri_remove_empty_na(colnames2019Q3)

length(df2019Q1)
df2019Q1 <- df2019Q1[colnamesInnerJoin]
length(df2019Q1)

length(df2019Q3)
df2019Q3 <- df2019Q3[colnamesInnerJoin]
length(df2019Q3)

#df2019 <- merge(df2019Q1, df2019Q3, by="RID", all=F)
df2019 <- rbind(df2019Q1, df2019Q3)
length(df2019)