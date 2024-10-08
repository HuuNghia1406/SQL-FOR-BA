
-- BETWEEN..AND
SELECT ProductID, Name, Color, SellStartDate
from SalesLT.Product
WHERE SellStartDate BETWEEN '2002-06-01 00:00:00.000' and '2005-07-01 00:00:00.000'

-- IN
SELECT ProductID, Name, Color, SellStartDate
from SalesLT.Product
WHERE Color IN ('Red','Black')

--LIKE

SELECT ProductID, Name, Color, SellStartDate
from SalesLT.Product
WHERE Name LIKE '%ROAD%' and Name LIKE '%Frame%'

SELECT ProductID, Name, Color, SellStartDate
from SalesLT.Product
where name like 'ROAD_____[^B]%'
