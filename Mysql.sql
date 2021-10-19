create database if not exists Dev;
use Dev;
-- drop table if exists country;
-- drop table if exists contact_status;
-- drop table if exists Account;
-- drop table if exists Contact;
-- drop table if exists Opportunity;
-- drop table if exists opportunity_sales_stage;

CREATE TABLE countrys (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(128) NOT NULL
);

CREATE TABLE contact_statuss (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(128) NOT NULL
);

CREATE TABLE opportunity_sales_stage (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(128) NOT NULL
);

CREATE TABLE Accounts (
    Id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(128) NOT NULL,
    parent_account_id int,
FOREIGN KEY (parent_account_id)
        REFERENCES Accounts (Id),
    revenue NUMERIC,
    countrys INT,
    FOREIGN KEY (countrys)
        REFERENCES countrys (Id),
    description TEXT,
    PRIMARY KEY (Id)
);

CREATE TABLE Contacts (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    firstname VARCHAR(128),
    lastname VARCHAR(128) NOT NULL,
    department VARCHAR(128),
    status INT,
    FOREIGN KEY (status)
        REFERENCES contact_statuss (Id),
    account_id INT,
    FOREIGN KEY (account_id)
        REFERENCES Accounts (Id),
        reports_to_id int,
        FOREIGN KEY (reports_to_id)
        REFERENCES Contacts (Id),
    left_the_org BOOLEAN
);

CREATE TABLE Opportunity (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(128) NOT NULL,
    amount NUMERIC,
    close_dare DATE,
    contact_id INT,
    FOREIGN KEY (contact_id)
        REFERENCES Contacts (Id),
    sales_stage INT,
    FOREIGN KEY (sales_stage)
        REFERENCES opportunity_sales_stage (Id),
    account_id INT,
    FOREIGN KEY (account_id)
        REFERENCES Accounts (Id)
);





-- insert
INSERT INTO contact_statuss VALUES (1,'Aware Negative');
INSERT INTO contact_statuss VALUES (2,'Unaware');
INSERT INTO contact_statuss VALUES (3,'Aware Neutral');
INSERT INTO contact_statuss VALUES (4,'Aware Positive');
INSERT INTO contact_statuss VALUES (5,'Champion');

INSERT INTO opportunity_sales_stage VALUES (1,'Prospecting');
INSERT INTO opportunity_sales_stage VALUES (2,'Qualification');
INSERT INTO opportunity_sales_stage VALUES (3,'Needs Analysis');
INSERT INTO opportunity_sales_stage VALUES (4,'Value Proposition');
INSERT INTO opportunity_sales_stage VALUES (5,'Id. Decision Makers');
INSERT INTO opportunity_sales_stage VALUES (6,'Perception Analysis');
INSERT INTO opportunity_sales_stage VALUES (7,'Proposal/Price Quote');
INSERT INTO opportunity_sales_stage VALUES (8,'Negotiation/Review');
INSERT INTO opportunity_sales_stage VALUES (9,'Closed Won');
INSERT INTO opportunity_sales_stage VALUES (10,'Closed Lost');

INSERT INTO countrys VALUES (1,'India');
INSERT INTO countrys VALUES (2,'UK');
INSERT INTO countrys VALUES (3,'USA');
INSERT INTO countrys VALUES (4,'PKA');
INSERT INTO countrys VALUES (5,'EUR');

INSERT INTO Accounts VALUES (1,'Alpabet', 1, 2700000000, 1, 'Full SW');
INSERT INTO Accounts VALUES (2,'Google', 1, 490000000, 2, 'Full SW');
INSERT INTO Accounts VALUES (3,'Youtube', 1, 6080000000, 3, 'Full SW');
INSERT INTO Accounts VALUES (4,'Calico', 1, 2900090000, 4, 'Full SW');
INSERT INTO Accounts VALUES (5,'GV', 1, 400009900, 5, 'Full Sw');
INSERT INTO Accounts VALUES (6,'Tata Group', 1, 6500000000, 4, 'Full All');
INSERT INTO Accounts VALUES (7,'Tata Chemicals', 6, 2340000000, 1, 'Full chemicals');
INSERT INTO Accounts VALUES (8,'Tata Power', 6, 412000000, 2, 'Full Power');
INSERT INTO Accounts VALUES (9,'Tata Steel', 6, 6050000000, 5, 'Full Steel');
INSERT INTO Accounts VALUES (10,'Amazon', 1, 2345000000, 3, 'Full online');
INSERT INTO Accounts VALUES (11,'IMDb', 10, 400780000, 4, 'Full Review');
INSERT INTO Accounts VALUES (12,'Flipkart', 1, 6000009999, 5, 'Full shop');

INSERT INTO Contacts VALUES (1,'Ram', 'Mohan', 'IT', 1, 2, 1, true);
INSERT INTO Contacts VALUES (2,'Shyam', 'Kumar', 'Engineering', 3, 3, 1, true);
INSERT INTO Contacts VALUES (3,'Kiyam', 'Rai', 'Sales', 2, 7, 3, false);
INSERT INTO Contacts VALUES (4,'Max', 'Lee', 'IT', 5, 9, 3, true);
INSERT INTO Contacts VALUES (5,'Yoo', 'Kim', 'Engineering', 4, 11, 5, true);
INSERT INTO Contacts VALUES (6,'Sam', 'Dou', 'Sales', 4, 4, 6, false);

INSERT INTO Opportunity VALUES (1,'Max hiring', 45000000, 31/05/2022, 1, 1, 2);
INSERT INTO Opportunity VALUES (2,'Max Sales', 35000000, 13/07/2027, 2, 2, 3);
INSERT INTO Opportunity VALUES (3,'Max Development', 77770000, 02/11/2023, 2, 3, 7);
INSERT INTO Opportunity VALUES (4,'Futher', 78900000, 05/09/2026, 1, 7, 10);
INSERT INTO Opportunity VALUES (5,'Sales', 80000000, 25/10/2024, 2, 10, 12);
INSERT INTO Opportunity VALUES (6,'Max Testing', 70000999, 08/04/2028, 2, 5, 4);
INSERT INTO Opportunity VALUES (7,'Max Win', 110000000, 08/04/2028, 2, 9, 7);
INSERT INTO Opportunity VALUES (8,'Win', 7000000, 08/04/2028, 3, 9, 7);
INSERT INTO Opportunity VALUES (9,'Max Win', 120000000, 08/04/2028, 4, 9, 7);

-- fetch
SELECT 
    *
FROM
    Accounts;
SELECT 
    *
FROM
    Contacts;
SELECT 
    *
FROM
    Opportunity;


--show all won opportunities whose amount is greater than 1 million
SELECT 
    sales_stage, amount
FROM
    Opportunity
WHERE
    amount >= 100000000 AND sales_stage = 9;

--show contact name in formatted manner 
select Id, concat(firstname," ",lastname) as name from Contacts;

--show status wise contact count
select count(Id), status from Contacts group by(status);


--show all aware negative contacts who are associated with opportunities
select Contacts.Id, Contacts.firstname, Contacts.status, Opportunity.name, Opportunity.contact_id  from Contacts 
right join Opportunity on Contacts.Id = Opportunity.contact_id 
where Contacts.status = 1;

--get account name which contains highest number of opportunities
select  Accounts.Id, Accounts.name, Opportunity.name, count(Opportunity.account_id)from Opportunity 
right join Accounts on Opportunity.account_id = Accounts.Id 
group by Opportunity.account_id
order by count(Opportunity.account_id) desc limit 0,1;

--get account name which contains highest number of contacts
select  Accounts.Id, Accounts.name, Contacts.firstname, count(Contacts.account_id)from Contacts  
right join Accounts on Contacts.account_id = Accounts.Id 
group by Contacts.account_id
order by count(Contacts.account_id) desc limit 0,1;

--show account wise opportunity & contact count
select Accounts.Id, Accounts.name, Opportunity.name,count(Opportunity.account_id) from Opportunity
right join Accounts on Accounts.Id = Opportunity.account_id
group by Opportunity.account_id
order by count(Opportunity.account_id) desc limit 0,1;

select Accounts.Id, Accounts.name, contacts.firstname,count(contacts.account_id) from contacts
right join Accounts on Accounts.Id = contacts.account_id
group by contacts.account_id
order by count(contacts.account_id) desc limit 0,1;


--get list of all parent accounts & child accounts
SELECT a.name as ParentAcc, b.name as ChildAcc
FROM Accounts a 
INNER JOIN Accounts b
ON a.id = b.parent_account_id;

--get account name which contains highest number of child account
SELECT 
    Id,name
FROM
    accounts
WHERE
    id = (SELECT 
            parent_account_id
        FROM
            accounts
        GROUP BY parent_account_id
        ORDER BY COUNT(id) DESC
        LIMIT 0 , 1);

--show account wise child accounts count
SELECT a.name as ParentAcc, count(b.name) as ChildAcc
FROM Accounts a 
INNER JOIN Accounts b
ON a.id = b.parent_account_id
group by ParentAcc;

