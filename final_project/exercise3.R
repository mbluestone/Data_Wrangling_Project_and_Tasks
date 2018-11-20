# load the libraries needed
library(RODBC)
library(tidyverse)

# connect to the odbc driver
# my personal username and password to connect to the sql server have been ommitted for the purpose of sharing this code publicly
dbhandle <- odbcDriverConnect('driver={SQL Server};server=qbs181-db.dartmouth.edu,40062;database=qbs181;uid=*****;pwd=*****')

# query the different tables needed
demo <- sqlQuery(dbhandle, 'select * from dbo.Demographics')
chro <- sqlQuery(dbhandle, 'select * from dbo.ChronicConditions')
text <- sqlQuery(dbhandle, 'select * from dbo.Text')

# join the three tables and remove unnecessary columns
fulldata <- inner_join(demo,chro,by=c("contactid"="tri_patientid")) %>%
  inner_join(.,text,by=c("contactid"="tri_contactId")) %>%
  select(-test,-gh1,-gh2,-gh3,-gh4,-gh5,-pf02)

# get the most recent text date for each participant
# and then only look at the data collected on each participant's most recent text date
fulldata %>%
  group_by(contactid) %>%
  summarise(LatestTextSent=max(TextSentDate)) %>%
  inner_join(fulldata,by="contactid") %>%
  filter(LatestTextSent==TextSentDate) %>%
  sample_n(10)