select top 10 * from
(select *,max(TextSentDate) over(partition by contactid) as LatestTextDate from
(select A.*, B.*,C.* from
dbo.Demographics A
inner join
dbo.ChronicConditions B
on
A.contactid=B.tri_patientid
inner join
dbo.Text C
on
A.contactid=C.tri_contactId) AA) BB
where TextSentDate=LatestTextDate
order by newid()
