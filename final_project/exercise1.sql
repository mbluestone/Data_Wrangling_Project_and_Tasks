--1a
EXEC sp_rename 'mbluestone.IC_BP.BPAlerts', 'BPStatus', 'COLUMN'

select top 10 * from mbluestone.IC_BP order by newid()

--1b
update mbluestone.IC_BP
set BPStatus = 1
where BPStatus = 'Hypo1' 

update mbluestone.IC_BP
set BPStatus = 1
where BPStatus = 'Normal'

update mbluestone.IC_BP
set BPStatus = 0
where BPStatus = 'Hypo2' 

update mbluestone.IC_BP
set BPStatus = 0
where BPStatus = 'HTN1'

update mbluestone.IC_BP
set BPStatus = 0
where BPStatus = 'HTN2' 

update mbluestone.IC_BP
set BPStatus = 0
where BPStatus = 'HTN3'

select top 10 * from mbluestone.IC_BP order by newid()

--1c
select top 10 ID,SystolicValue,Diastolicvalue,BPStatus,ObservedTime,tri_imaginecareenrollmentemailsentdate,tri_enrollmentcompletedate from
(select A.*, B.* from
mbluestone.IC_BP A
inner join
Demographics B
on
A.ID=B.contactid) AA
order by newid()

--1d
select top 10 ID,WeekInterval,avg(convert(decimal,BPStatus)) as AvgScore from
(select ID,BPStatus,(datediff(week,mintime,ObservedTime)+1) as WeekInterval from
(select ID,BPStatus,ObservedTime,min(ObservedTime) over(partition by ID) as mintime 
from mbluestone.IC_BP) AA
where BPStatus!='NULL') BB
where WeekInterval <= 12
group by ID,WeekInterval
order by newid()

select top 10 * from mbluestone.IC_BP order by newid()

--1e
select WeekInterval,avg(convert(decimal,BPStatus)) as AvgScore from
(select ID,BPStatus,(datediff(week,mintime,ObservedTime)+1) as WeekInterval from
(select ID,BPStatus,ObservedTime,min(ObservedTime) over(partition by ID) as mintime 
from mbluestone.IC_BP) AA
where BPStatus!='NULL') BB
where WeekInterval = 12 or WeekInterval = 1
group by WeekInterval

--1f
select count(distinct ID) AS CustomerCount from
(select ID,BPStatus,(datediff(week,mintime,ObservedTime)+1) as WeekInterval from
(select ID,BPStatus,ObservedTime,min(ObservedTime) over(partition by ID) as mintime 
from mbluestone.IC_BP) AA
where BPStatus!='NULL') BB
where WeekInterval > 12 AND BPStatus = '1'
