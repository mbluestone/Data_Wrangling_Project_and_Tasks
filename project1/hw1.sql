-- 1.
select contactid as ID,
gendercode as Gender,
tri_age as Age,
parentcontactidname as Parent,
tri_imaginecareenrollmentstatus as EnrollmentStatusCode,
address1_stateorprovince as State,
tri_imaginecareenrollmentemailsentdate as EmailSentDate,
tri_enrollmentcompletedate as CompleteDate,
datediff(day,try_convert(date,tri_imaginecareenrollmentemailsentdate),
try_convert(date,tri_enrollmentcompletedate)) as TimeToComplete
into mbluestone.hw1 from Demographics

-- show 10 random rows from db
select top 10 * from mbluestone.hw1 order by newid()

-- 2.
alter table mbluestone.hw1
add EnrollmentStatus nvarchar(255)

update mbluestone.hw1
set EnrollmentStatus = 'Complete'
where EnrollmentStatusCode = 167410011

update mbluestone.hw1
set EnrollmentStatus = 'Email Sent'
where EnrollmentStatusCode = 167410001

update mbluestone.hw1
set EnrollmentStatus = 'Non Responder'
where EnrollmentStatusCode = 167410004

update mbluestone.hw1
set EnrollmentStatus = 'Facilitated Enrollment'
where EnrollmentStatusCode = 167410005

update mbluestone.hw1
set EnrollmentStatus = 'Incomplete Enrollments'
where EnrollmentStatusCode = 167410002

update mbluestone.hw1
set EnrollmentStatus = 'Opted Out'
where EnrollmentStatusCode = 167410003

update mbluestone.hw1
set EnrollmentStatus = 'Unprocessed'
where EnrollmentStatusCode = 167410000

update mbluestone.hw1
set EnrollmentStatus = 'Second Email Sent'
where EnrollmentStatusCode = 167410006

-- show 10 random rows from db
select top 10 * from mbluestone.hw1 order by newid()

-- 3.
alter table mbluestone.hw1
add Sex nvarchar(255)

update mbluestone.hw1
set Sex = 'Female'
where Gender = '2'

update mbluestone.hw1
set Sex = 'Male'
where Gender = '1'

update mbluestone.hw1
set Sex = 'Other'
where Gender = '167410000'

update mbluestone.hw1
set Sex = 'Unknown'
where Gender = 'NULL'

-- show 10 random rows from db
select top 10 * from mbluestone.hw1 order by newid()

-- 4.
alter table mbluestone.hw1
add AgeGroup nvarchar(255)

update mbluestone.hw1
set AgeGroup = '0-25'
where Age < 26

update mbluestone.hw1
set AgeGroup = '0-25'
where Age <= 25

update mbluestone.hw1
set AgeGroup = '26-50'
where Age >= 26 and Age <= 50

update mbluestone.hw1
set AgeGroup = '51-75'
where Age >= 51 and Age <= 75

update mbluestone.hw1
set AgeGroup = '76-100'
where Age >= 76 and Age <= 100

-- show 10 random rows from db
select top 10 * from mbluestone.hw1 order by newid()