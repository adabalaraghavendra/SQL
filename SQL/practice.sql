show databases;
use StudentDatabase;
create table StudentDetails(ID INT, NAME char(20), AGE tinyint, GENDER CHAR(10));
select * from StudentDetails;
insert into StudentDetails values(1,"raju",20,"male");
insert into StudentDetails values(2,"siri",18,"female");
insert into StudentDetails values(3,"ravi",20,"male"),(4,'prasad',21,'male');
select * from StudentDetails;
update StudentDetails set NAME="raghava" WHERE ID=1;
SET SQL_SAFE_UPDATES=0;
DELETE FROM StudentDetails where ID=4;

delete from StudentDetails where ID In (2,3);
delete from StudentDetails;
truncate  table StudentDetails;

alter table StudentDetails ADD Location varchar(20);

update StudentDetails set Location="INDIA";
drop table StudentDetails; 
 create table CourceDetails(
           CourceID tinyint primary key,
           CourceName varchar(20) not null,
           Fee smallint
 );
 select * from CourceDetails;
 insert into CourceDetails values(1,'SQL',15000);
 insert into CourceDetails values(2,'Power By',12000);
 update CourceDetails set CourceNAme='Power BI' where CourceID=2;
 
 create table StudentDetails(
                 StudentID int primary key,
                 Name char(30) not null,
                 Age tinyint check(Age>18),
                 Gender varchar(20)check(Gender='Male' or Gender='Female'),
                 CourceID tinyint,
                 foreign key(CourceID) references CourceDetails(CourceID)
                 
);
select * from StudentDetails;

insert into StudentDetails values(1,'Raju',21,'Male',1);
insert into StudentDetails values(2,'Siri',19,'Female',1);
insert into StudentDetails values(3,'Raghava',21,'Male',2);
insert into StudentDetails(StudentID,Name,Age,Gender,CourceID) values(4,'purna',22,'Male',2);

alter table Studentdetails add Location varchar(20);
update studentdetails set location="Bangalur" where StudentID in(1,3);
update studentdetails set location="Hyderabad" where StudentID in(2,4);
select count(*) as countofstudents from studentdetails; 
select count(*) as countofstudents from studentdetails where Location='Hyderabad';
select count(*) as countofstudents from studentdetails where Location='Bangulur';
select Location,count(*) As countofstudents from studentdetails 
                         group by Location;
select * from studentdetails order by Name desc;
select * from studentdetails limit 3;
select sd.StudentID,sd.Name,sd.Age,sd.Gender,sd.CourceID,cd.CourceName,cd.Fee,sd.Location
                         from studentdetails as sd
                         join courcedetails as cd
                         on sd.CourceID=cd.CourceID;
select sd.StudentID,sd.Name,sd.Age,sd.Gender,sd.CourceID,cd.CourceName,cd.Fee,sd.Location
                         from studentdetails as sd
                         left join courcedetails as cd
                         on sd.CourceID=cd.CourceID;
select sd.StudentID,sd.Name,sd.Age,sd.Gender,sd.CourceID,cd.CourceName,cd.Fee,sd.Location
                         from studentdetails as sd
                         right join courcedetails as cd
                         on sd.CourceID=cd.CourceID;
select sd.StudentID,sd.Name,sd.Age,sd.Gender,sd.CourceID,cd.CourceName,cd.Fee,sd.Location
                         from studentdetails as sd
                         left join courcedetails as cd
                         on sd.CourceID=cd.CourceID
union
select sd.StudentID,sd.Name,sd.Age,sd.Gender,sd.CourceID,cd.CourceName,cd.Fee,sd.Location
                         from studentdetails as sd
                         right join courcedetails as cd
                         on sd.CourceID=cd.CourceID;
select * from studentdetails,courcedetails;
create table EmployeeTable(
                            EmpID int,
                            EmpName char(20),
                            ManagerID int);
select * from EmployeeTable;
insert into EmployeeTable values(1,'Billgates',null),
								(2,'Purna',1),
                                (3,'Rahghava',2),
                                (4,'Siri',2),
                                (5,'Raju',null);
select E1.EmpID,E1.EmpName,E2.EmpName as ManagerName from EmployeeTable as E1 left join
												 EmployeeTable as E2 
                                                 on E1.ManagerID=E2.EmpId;
update EmployeeTable set ManagerID=4 where EmpID=5;
set sql_safe_updates=0;