#############################################
## This script does the following ##
## 1. Install packages needed for this application.
## 2. Create a "data" directory if it doesnot exists in current working directory 
## 3. Download the needed files from Georgia Department of Education website (if files do not exists)
## 4. Pre-processes the data and prepare the data frames needed for reporting 
#############################################


# Setup environment needed
if (require("shiny") == FALSE)  install.packages("shiny")
if (require("XLConnect") == FALSE)  install.packages("XLConnect")
if (require("gdata") == FALSE)  install.packages("gdata")

library(slidify)
require(XLConnect)
require(gdata)

# Create data directory if it doesnot exist

if (!file.exists("data")) dir.create("data")

# Download Georgia Public Schools District File 
if (!file.exists("data/CCRPI.xls"))
download.file("http://www.gadoe.org/CCRPI/Documents/2014/2014%20CCRPI%20Indicator%20Score.xls",destfile="data/CCRPI.xls",mode="wb")

# Download Georgia Public School SAT and AP File 
if (!file.exists("data/SATandAP.xlsx"))
download.file("http://www.gadoe.org/Curriculum-Instruction-and-Assessment/Curriculum-and-Instruction/Documents/COLLEGE%20READINESS/2014-SAT-GA-School-Level.xlsx",destfile="data/SATandAP.xlsx",mode="wb")

# Download Georgia Public School ACT File 
if (!file.exists("data/ACT.xls"))
download.file("http://www.gadoe.org/Curriculum-Instruction-and-Assessment/Curriculum-and-Instruction/Documents/COLLEGE%20READINESS/2014-ACT-GA-School-Level.xls",destfile="data/ACT.xls",mode="wb")

# School Names cleanup so they can be mapped to corresponding School Districts
source("schoolNameCleanup.R")

# Load Georgia Department of Education 2014 High Schools and School Districts into a data.frame

wb <- loadWorkbook("data/CCRPI.xls")
CCRPI <- readWorksheet(wb, sheet = "Sheet1", header = TRUE)
# Keep only High School Records
gadoeHS<-unique(CCRPI[CCRPI$GRADE.CLUSTER.DESC=="High School" & CCRPI$SYSTEM.ID!="ALL" & CCRPI$SCHOOL.NAME!="All Schools",c(1:5)])
gadoeHS$SCHOOL.NAME<-trim(gadoeHS$SCHOOL.NAME)

# Load SAT data and Clean school district information
wb1 <- loadWorkbook("data/SATandAP.xlsx")
SATAP <- readWorksheet(wb1, sheet = "Table 1", header = TRUE,startRow=4)
SATAP$High.School<-trim(SATAP$High.School)

# Keep only relevant columns in SAT data
SAT<-suppressWarnings(unique(SATAP[-which(is.na(as.numeric(SATAP$Col2))),c(1:6)]))
# Match Schools by Name and ID using applications on GADOE website
SAT<-schoolNameCleanup(SAT)
SAT<-merge(SAT, gadoeHS, by.x="High.School", by.y = "SCHOOL.NAME", all.x=TRUE)
# Discard Schools not matched to Districts
# nrow(SAT[which(is.na(SAT$SCHOOL.ID)),c(1,2)])
SAT<-SAT[-which(is.na(SAT$SCHOOL.ID)),]


## Matched High Schools to School Districts. This list used for matching AP and ACT data to keep data consistent
matched_schools<-unique(SAT[,c(2,8,9,10,1)])
names(matched_schools)<-c("AICODE" , "SYSTEM.ID","SYSTEM.NAME","SCHOOL.ID","High.School")

# Load AP data and Clean school district information
## Keep only relevant columns in AP data
AP<-suppressWarnings(unique(SATAP[-which(is.na(as.numeric(SATAP$Col2))),c(1,2,9,10,11)]))
# Map District information with AP High School Data
AP<-merge(AP, matched_schools, by.x="Col2", by.y = "AICODE", all.x=TRUE)
# Number of High Schools did not match
#nrow(AP[which(is.na(AP$SCHOOL.ID)),])
# Discard Schools not matched to Districts
AP<-AP[-which(is.na(AP$SCHOOL.ID)),]

## Load ACT Data and Clean school district information
wb2 <- loadWorkbook("data/ACT.xls")
ACTdf <- readWorksheet(wb2, sheet = "Sheet1", header = TRUE)
ACT<-ACTdf[,c(2,4,5,6,7,8,9,10,11,12)]
names(ACT)<-c("District.Name","School","AICODE","School_Year","Test_Takers","Avg.Eng","Avg.Math","Avg.Reading","Avg.Science","Avg_Composite" )
# Map District information with ACT High School Data
ACT<-merge(ACT, matched_schools, by.x="AICODE", by.y = "AICODE", all.x=TRUE)
# nrow(ACT[which(is.na(ACT$SCHOOL.ID)),])
# Discard Schools not matched to Districts
ACT<-ACT[-which(is.na(ACT$SCHOOL.ID)),]

## Pre-process SAT data frame for reporting and add calculated columns like Avg_Combined, State.Rank ETC.

names(SAT) <-c( "School","AICode","Test_Takers","Avg_Reading", "Avg_Math","Avg_Writing",
                "School_Year","District_Code","District","School_Code" )
SAT$Avg_Reading<-suppressWarnings(as.numeric(gsub(",", "",SAT$Avg_Reading)))
SAT$Avg_Math<-suppressWarnings(as.numeric(gsub(",", "",SAT$Avg_Math)))
SAT$Avg_Writing<-suppressWarnings(as.numeric(gsub(",", "",SAT$Avg_Writing)))
SAT$Avg_Combined<-SAT$Avg_Reading+SAT$Avg_Math+SAT$Avg_Writing
SAT$State.Rank<-rank(-SAT$Avg_Combined, na.last = TRUE,ties.method = "max")
SAT<-SAT[order(SAT$State.Rank),]
SAT<-SAT[,c(8,9,10,1,11,12,3,4,5,6,7,2)]
SAT2014<-SAT

## Pre-process AP data frame for reporting and add calculated columns like AP_PASS_PCT, State.Rank etc

names(AP)<-c("AICode","School","Test_Takers","Total.Exams.Taken","Num.of.Exams.with.Scores.3.4.or.5"  ,              
             "District_Code" ,"District","School_Code" ,"High.School.y"	)
AP$Total.Exams.Taken<- suppressWarnings(as.numeric(gsub(",", "", AP$Total.Exams.Taken)))
AP$Num.of.Exams.with.Scores.3.4.or.5<- suppressWarnings(as.numeric(gsub(",", "",AP$Num.of.Exams.with.Scores.3.4.or.5)))
AP$Test_Takers<- suppressWarnings(as.numeric(gsub(",", "",AP$Test_Takers)))
AP$AP_PASS_PCT<- round(AP$Num.of.Exams.with.Scores.3.4.or.5/AP$Total.Exams.Taken*100,2)
AP$State.Rank<-rank(-AP$AP_PASS_PCT, na.last = TRUE,ties.method = "max")
AP<-AP[,c(6,7,8,2,10,11,3,4,5,1)]
AP<-AP[order(AP$State.Rank),]
AP2014<-AP

## Pre-process ACT data frame for reporting and add calculated columns like State.Rank

names(ACT)<-c("AICODE","District_ACT","School_ACT","School_Year","Test_Takers",  
              "Avg_Eng","Avg_Math","Avg_Reading","Avg_Science","Avg_Composite",
              "District_Code",  "District","School_Code",  "School")  
ACT$State.Rank<-rank(-ACT$Avg_Composite, na.last = TRUE,ties.method = "max")
ACT<-ACT[order(ACT$State.Rank),]
ACT<-unique(ACT[,c(11,12,13,14,10,15,5,6,7,8,9,1,4)])
names(ACT)<-c("District_Code","District","SCHOOL.ID","School" ,"Avg_Composite" ,"State.Rank",
"Test_Takers","Avg_Eng","Avg_Math","Avg_Reading","Avg_Science","AICODE","School_Year" ) 
ACT2014<-ACT
