show databases;
CREATE DATABASE Bankdatabase;
use Bankdatabase;
create table AccountDetails(
                AccountID int primary key,
                Name char(30) not null,
                Age tinyint check(Age>18),
                AccountType varchar(20),
                CurrentBalence int
);
select * from AccountDetails;
drop table  AcountDetails;
insert into AccountDetails values(1,'raju',21,'savings',1000);
select now();
create table TransactionDetails(
              TransactionID int primary key auto_increment,
              AccountID int,
              TransactionType varchar(10) check(TransactionType='Credit' or TransactionType='Debit'),
              TransactionAmount int,
              TransactionTime datetime default(now()),
              foreign key(AccountID) references AccountDetails(AccountID)
);
select * from TransactionDetails;
# drop table TransactionDetails;
insert into TransactionDetails(AccountID,TransactionType,TransactionAmount)
                       values(1,'Credit',1000);
insert into TransactionDetails(AccountID,TransactionType,TransactionAmount)
                       values(1,'Debit',1000);
insert into AccountDetails values(2,'purna',22, 'savings',50000),
								(3,'Raghava',25, 'current',5000),
                                (4,'Siri',20,'savings',2000),
                                (5,'pandu',27, 'current',1000),
                                (6,'Prasad',21, 'current',500),
                                (7,'sai',29,'savings',2500),
                                (8,'jaya',23,'current',1500),
                                (9,'pavan',21,'savings',3000),
                                (10,'mouni',20,'savings',4000);
				
insert into TransactionDetails(AccountID,TransactionType,TransactionAmount)
                       values(7,'Credit',1000);
select distinct(AccountId) from TransactionDetails;
select distinct(AccountId) from TransactionDetails;
select * from AccountDetails where AccountId in(select distinct(AccountId) from TransactionDetails
);            
select min(CurrentBalence) from AccountDetails where CurrentBalence in 
(select CurrentBalence from AccountDetails order by CurrentBalence desc limit 5);
select CurrentBalence from AccountDetails order by CurrentBalence desc limit 5;
select min(CurrentBalence) from 
(select CurrentBalence from AccountDetails order by CurrentBalence desc limit 6) as Top5Balence;
select min(CurrentBalence) as minimumvalue from AccountDetails ;
select max(CurrentBalence) from AccountDetails where CurrentBalence <
(select max(CurrentBalence) from AccountDetails where CurrentBalence  <
(select max(CurrentBalence) from AccountDetails));
select max(CurrentBalence) from AccountDetails;

create view AccountOfTransaction as
select * from AccountDetails where AccountID in
(select distinct(AccountID) from TransactionDetails);
select  * from  AccountOfTransaction ;

create view BalanceInBank as
select sum(CurrentBalence) from AccountDetails;
select * from BalanceInBank;

insert into TransactionDetails(AccountID,TransactionType,TransactionAmount)
                       values(5,'Credit',5000);
create index AccountIdIndex  using btree on AccountDetails(AccountId);
drop index AccountIdIndex on  AccountDetails;  

create view BankStatements as 
select * from TransactionDetails where AccountId=1;  

select * from BankStatements;   
call bankdatabase.MiniStatement(2);      
alter table AccountDetails add AccountStatus char(20) default("Active");
select *  from AccountDetails;

set sql_safe_updates=0;

select * from  TransactionDetails;
truncate tABLE TransactionDetails;
update AccountDetails set CurrentBalence=0;
delimiter $$
create trigger BalenceUpdater 
after insert  on TransactionDetails for each row
begin

declare Var_LatestTransactionId int;
declare Var_AccountId int;
declare Var_TransactionType char(10);
declare Var_TransactionAmount int;
declare Var_CurrentBalence int;
select  max(TransactionID) into Var_LatestTransactionId  from TransactionDetails;
select AccountID,TransactionType,TransactionAmount into Var_AccountId , Var_TransactionType, Var_TransactionAmount from TransactionDetails
          where TransactionID=Var_LatestTransactionId ;
select CurrentBalence into Var_CurrentBalence from AccountDetails where AccountID=Var_AccountId ;
if Var_TransactionType="Credit"
then
update Accountdetails set CurrentBalence = CurrentBalence+Var_TransactionAmount where AccountID=Var_AccountId;
else
if Var_TransactionAmount <= Var_CurrentBalence then
update Accountdetails set CurrentBalence = CurrentBalence-Var_TransactionAmount where AccountID=Var_AccountId;
else
update Accountdetails set CurrentBalence = CurrentBalence where AccountID=Var_AccountId;
end if;
end if;

end;
delimiter ;
drop trigger BalenceUpdater; 



insert into TransactionDetails(AccountID,TransactionType,TransactionAmount)value(1,"Credit",10000);
select * from TransactionDetails;
select * from AccountDetails;
insert into TransactionDetails(AccountID,TransactionType,TransactionAmount)value(1,"Debit",1000);
insert into TransactionDetails(AccountID,TransactionType,TransactionAmount)value(5,"credit",1000);
insert into TransactionDetails(AccountID,TransactionType,TransactionAmount)value(5,"credit",100000);
insert into TransactionDetails(AccountID,TransactionType,TransactionAmount)value(5,"debit",50000);



delimiter $$
create trigger  CascadingDelete
before delete on AccountDetails for each row
begin
delete from TransactionDetails where AccountID =old.AccountID;
end

delimiter ;
delete from AccountDetails where AccountID=5;

set autocommit=0;

start transaction;
select * from AccountDetails;
delete from AccountDetails where AccountID=10;
rollback;
commit;



