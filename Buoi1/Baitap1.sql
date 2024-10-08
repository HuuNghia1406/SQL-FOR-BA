
/* TASK 1: Retrieve data for transportation reports
1.1 Retrieve a list of cities
Initially, you need to produce a list of all of your customers' locations. 
Write a Transact-SQL query that queries the SalesLT.Address table and retrieves the values for City and StateProvince, removing duplicates,
then sorts in ascending order of StateProvince and descending order of City.
*/

SELECT DISTINCT City, StateProvince
FROM SalesLT.Address
ORDER BY StateProvince asc , City desc;

/*1.2  Retrieve the heaviest products information
Transportation costs are increasing and you need to identify the heaviest products. 
Retrieve the names, weight of the top ten percent of products by weight.   
*/

SELECT TOP 10 PERCENT Name, Weight
from SalesLT.Product
ORDER BY Weight desc;

/* TASK 2: Retrieve product data
2.1  Filter products by color and size
Retrieve the product number and name of the products that have a color of black, red, or white and a size of S or M.
*/


SELECT Name, Color, Size
from SalesLT.Product
WHERE Color IN ('Black','Red','White') and Size IN ('S','M')

/*2.2 Filter products by color, size, and product number
Retrieve the ProductID, ProductNumber, and Name of the products that must have a Product number beginning with 'BK-',
 followed by any character other than 'T', and ending with a '-' followed by any two numerals. And satisfy one of the following conditions:
Color of black, red, or white
Size is S or M   
*/


SELECT ProductID,Color,[Size],ProductNumber
from SalesLT.Product
WHERE ProductNumber LIKE 'BK-%[^T]%-[10-99]%'
/* 2.3  Retrieve specific products by product ID
Retrieve the product ID, product number, name, and list price of products whose product name contains "HL" or "Mountain", 
product number is at least 8 characters, and have never been ordered.   
*/
SELECT * from SalesLT.Product


SELECT ProductID, Name, ProductNumber, ListPrice
From SalesLT.Product
where Name LIKE 'HL%' or Name LIKE 'Mountain%'