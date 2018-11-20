library(RODBC)
library(tidyverse)
dbhandle <- odbcDriverConnect('driver={SQL Server};server=qbs181-db.dartmouth.edu,40062;database=qbs181;uid=mbluestone;pwd=mbluestone@qbs181')

demo <- sqlQuery(dbhandle, 'select * from dbo.Demographics')
chro <- sqlQuery(dbhandle, 'select * from dbo.ChronicConditions')
text <- sqlQuery(dbhandle, 'select * from dbo.Text')

fulldata <- inner_join(demo,chro,by=c("contactid"="tri_patientid")) %>%
  inner_join(.,text,by=c("contactid"="tri_contactId")) %>%
  select(-test,-gh1,-gh2,-gh3,-gh4,-gh5,-pf02)

fulldata %>%
  group_by(contactid) %>%
  summarise(LatestTextSent=max(TextSentDate)) %>%
  inner_join(fulldata,by="contactid") %>%
  filter(LatestTextSent==TextSentDate)