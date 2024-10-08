/* 
Task 1
1.1 Retrieve customer names and phone numbers
Each customer has an assigned salesperson. You must write a query to create a call sheet that lists:
+ The salesperson
+ A column named CustomerName that displays how the customer contact should be greeted (for example, Mr. Smith)   
+ The customer's phone number.   
*/

SELECT
     SUBSTRING(salesperson,CHARINDEX('\',salesperson)+1,LEN(salesperson)-CHARINDEX('\',salesperson)) as Name_salesperson
    ,CONCAT(LEFT(Title,3), ' ',LastName) as CustomerName
-- hoặc sử dụng concat_ws
    ,CONCAT_WS(' ',Title,LastName) as CustomerName_with_concast_ws
    , Phone
FROM SalesLT.Customer

/*1.2 Retrieve the heaviest products information
Transportation costs are increasing and you need to identify the heaviest products. Retrieve the names, weight of the top ten percent of products by weight. 
Then, add new column named Number of sell days (caculated from SellStartDate and SellEndDate) of these products (if sell end date isn't defined then get Today date) 
*/

select top 10 PERCENT name as NameProduct
    ,weight
    ,SellStartDate
    ,SellEndDate
-- Có thể tính khoảng cách giữa 2 ngày(tháng,năm,giờ,..) khác nhau
-- Cú pháp hàm DATEDIFF(interval, startdate, enddate)
-- vd1: tính số ngày giữa 2 thời gian
--CÁCH 1:
    ,IIF(SellEndDate is not null, DATEDIFF(day,SellStartDate,SellEndDate), DATEDIFF(day,SellStartDate,GETDATE())) as SellDays_1
--CÁCH 2:
    ,DATEDIFF(DAY, SellStartDate, COALESCE(SellEndDate, GETDATE())) AS SellDays_2
--CÁCH 3:
    ,DATEDIFF(day,SellStartDate,IIF(SellEndDate is null,GETDATE(),SellEndDate)) as SellDays_3
--CÁCH 4:
    ,DATEDIFF(day,SellStartDate,ISNULL(SellEndDate,GETDATE())) as SellDays_4
-- vd2: tính tuần, tháng,quý, năm
    ,DATEDIFF(week,SellStartDate,COALESCE(SellEndDate,GETDATE())) as number_weeks
    ,DATEDIFF(month,SellStartDate,COALESCE(SellEndDate,GETDATE())) as number_months
    ,DATEDIFF(quarter,SellStartDate,COALESCE(SellEndDate,GETDATE())) as number_quaters
    ,DATEDIFF(year,SellStartDate,COALESCE(SellEndDate,GETDATE())) as number_years
from salesLT.Product
ORDER By weight desc;


/*
1.3 Retrieve the information
    Get the second word in the Product Name column (words separated by spaces).
*/

SELECT ProductID
    ,NAME
   -- ,Case when LEN(name)-REPLACE(name,' ','') = 0 then null
        ,case when CHARINDEX(' ',name) =0 then name
            when CHARINDEX(' ',name,CHARINDEX(' ',name)+1) =0
     --   when LEN(name)-REPLACE(name,' ','') = 1 
            then RIGHT(name,len(name)-CHARINDEX(' ',name))
    else SUBSTRING(name,CHARINDEX(' ',name)+1, CHARINDEX(' ',name,CHARINDEX(' ',name)+1)-(CHARINDEX(' ',name)+1))
    END AS sencond_words
FROM salesLT.Product

/*
Task 2: Retrieve customer order data 
 
2.1 As you continue to work with the Adventure Works customer data, you must create queries for reports that have been requested by the sales team.
Retrieve a list of customer companies
You have been asked to provide a list of all customer companies in the format Customer ID : Company Name - for example, 78: Preferred Bikes
*/

SELECT CustomerID
    ,CompanyName
    ,CONCAT_WS(' ',FirstName,MiddleName,LastName) as [FullName]
    ,CONCAT(cast(CustomerID as varchar),': ',CompanyName) as CustomerCompany

from salesLT.customer

/*
2.2 List of Sales Order Revisions
The SalesLT.SalesOrderHeader table contains records of sales orders. You have been asked to retrieve data for a report that shows:
The sales order number and revision number in the format () – for example SO71774 (2).
The order date converted to ANSI standard 102 format (yyyy.mm.dd – for example 2015.01.31).
*/

select salesorderID
    ,Salesordernumber
    ,RevisionNumber
    ,Orderdate
    ,CONCAT(Salesordernumber,' (',cast(RevisionNumber as varchar),')') SalesOrderRevision
    ,CONVERT(varchar,Orderdate,102) as OrderDate_ANSI
from salesLT.salesorderheader

/*
TASK 3: Retrieve customer contact details (hard) 

3.1 Some records in the database include missing or unknown values that are returned as NULL. You must create some queries that handle these NULL values appropriately.
Retrieve customer contact names with middle names if known
You have been asked to write a query that returns a list of customer names. The list must consist of a single column in the format first last (for example Keith Harris) if the middle name is unknown, or first middle last (for example Jane M. Gates) if a middle name is known.
*/

select CustomerID
    ,FIRSTname
    ,middlename
    ,Lastname
--CÁCH 1:
    ,case when middlename is not NULL
    THEN CONCAT_WS(' ',FirstName,middlename,LastName)
    when middlename is  NULL THEN CONCAT_WS(' ',FirstName,LastName)
    else 'Error!'
    end as [FullName_with_casewhen]
--CÁCH 2:
    ,IIF([middlename] is not null,CONCAT_WS(' ',FirstName,middlename,LastName),CONCAT_WS(' ',FirstName,LastName)) as [fullname_with_IIF]
FROM saleslt.customer


/*
3.2 Retrieve primary contact details
Customers may provide Adventure Works with an email address, a phone number, or both. If an email address is available, 
then it should be used as the primary contact method; if not, 
then the phone number should be used. You must write a query that returns a list of customer IDs in one column, 
and a second column named PrimaryContact that contains the email address if known, and otherwise the phone number.
*/

select CustomerID
    ,CONCAT_WS(' ',FirstName,middlename,LastName) as FullName
    ,Coalesce(EmailAddress,Phone) PrimaryContact -- Nếu như EmailAddress tồn lại thì show email ra, còn nếu rỗng thì show Phone ra, nếu cả 2 đều rỗng, thì show 'null
FROM salesLT.customer

/*
3.3 As you continue to work with the Adventure Works customer, product and sales data, you must create queries for reports that have been requested by the sales team.
Retrieve a list of customers with no address
A sales employee has noticed that Adventure Works does not have address information for all customers. 
You must write a query that returns a list of customer IDs, company names, contact names (first name and last name), and phone numbers for customers 
with no address stored in the database.
*/

select customerID
    ,CompanyName
    ,CONCAT_WS(' ',FirstName,LastName) as [FullName_with_CONCAT_WS]
    ,phone
from salesLT.customer
where customerID not in (SELECT customerID from salesLT.CustomerAddress)

