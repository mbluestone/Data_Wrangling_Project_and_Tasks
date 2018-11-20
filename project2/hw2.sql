--1.
select * dbo.PhoneCall into mbluestone.hw2

alter table mbluestone.hw2
add EnrollmentGroup nvarchar(255)

update mbluestone.hw2
set EnrollmentGroup = 'Clinical Alert'
where EncounterCode = 125060000

update mbluestone.hw2
set EnrollmentGroup = 'Health Coaching'
where EncounterCode = 125060001

update mbluestone.hw2
set EnrollmentGroup = 'Technical Question'
where EncounterCode = 125060002

update mbluestone.hw2
set EnrollmentGroup = 'Administrative'
where EncounterCode = 125060003

update mbluestone.hw2
set EnrollmentGroup = 'Other'
where EncounterCode = 125060004

update mbluestone.hw2
set EnrollmentGroup = 'Lack of Engagement'
where EncounterCode = 125060005

select top 10 * from mbluestone.hw2 order by newid()

--2.
select EnrollmentGroup, count(CustomerId) as Count from mbluestone.hw2
group by EnrollmentGroup

--3.
select A.*, B.* from 
mbluestone.hw2 A
inner JOIN
dbo.CallDuration B
on
A.CustomerId=B.tri_CustomerIDEntityReference

--4.
select * into mbluestone.hw2_cd from dbo.CallDuration

alter table mbluestone.hw2_cd alter column CallType VARCHAR(50)
alter table mbluestone.hw2_cd alter column CallOutcome VARCHAR(50)

update mbluestone.hw2_cd
set CallType = 'Inbound'
where CallType = '1'

update mbluestone.hw2_cd
set CallType = 'Outbound'
where CallType = '2'

update mbluestone.hw2_cd
set CallOutcome = 'No Response'
where CallOutcome = '1'

update mbluestone.hw2_cd
set CallOutcome = 'Left Voice Mail'
where CallOutcome = '2'

update mbluestone.hw2_cd
set CallOutcome = 'Successful'
where CallOutcome = '3'

select CallType, CallOutcome, count(tri_CustomerIDEntityReference) as Count from mbluestone.hw2_cd
group by CallType, CallOutcome

--
select EnrollmentGroup, avg(CallDuration) as CallDuration from
(select A.*, B.* from 
mbluestone.hw2 A
inner JOIN
dbo.CallDuration B
on
A.CustomerId=B.tri_CustomerIDEntityReference) AA
group by EnrollmentGroup

--5.
select SenderName, (count/diff) as TextsPerWeek from
(select SenderName,count(*) as count,
datediff(week,min(TextSentDate),max(TextSentDate)) as diff
from
(select A.*, B.*, C.* from 
dbo.Demographics A
inner JOIN
dbo.ChronicConditions B
on
A.contactID=B.tri_patientid
inner join
dbo.Text C
on A.contactID=C.tri_contactId) AA
group by SenderName) BB

--6.
select tri_name, (count/diff) as TextsPerWeek from
(select tri_name,count(contactid) as count,
datediff(week,min(TextSentDate),max(TextSentDate)) as diff
from
(select A.*, B.*, C.* from 
dbo.Demographics A
inner JOIN
dbo.ChronicConditions B
on
A.contactID=B.tri_patientid
inner join
dbo.Text C
on A.contactID=C.tri_contactId) AA
group by tri_name) BB

