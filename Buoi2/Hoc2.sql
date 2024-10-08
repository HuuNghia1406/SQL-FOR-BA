-- BUILT IN FUNCTIONS

-- 1. Ghép chuỗi ( string)
-- CONCAT(String1, String2,...Stringn)

SELECT FirstName
    , MiddleName
    , LastName
    , CONCAT(Firstname,MiddleName,Lastname) as FullName
    , CONCAT(Firstname,' ',MiddleName,' ',Lastname) as FullName1
    , CONCAT_WS(' ',Firstname,MiddleName,Lastname) as FullName2
FROM SalesLT.Customer
ORDER BY FullName ASC


-- 2. Thay thế giá trị null
-- Isnull(column_name,new_value)
SELECT FirstName
    , MiddleName
    , LastName
    , CONCAT_WS(' ',Firstname,MiddleName,Lastname) as FullName2
    --, isnull(MiddleName,'-') as new_middle_name 
    -- Thay thế chuỗi rồng bằng kí tự '-'
    , CONCAT(Firstname,isnull(MiddleName,'-'),Lastname) as FullName
    -- Thay thế trực tiếp vào kết quả hiển thị
FROM SalesLT.Customer
ORDER BY FullName ASC


-- 3. Các functions xử lí thời gian
SELECT TOP(10) CustomerID
    , Modifieddate
    ,YEAR(Modifieddate) as [year]
    ,MONTH(Modifieddate) as [month]
    ,DAY(Modifieddate) as [day]
-- Có thể thay thế bằng hàm datepart sẽ linh hoạt hơn
    ,DATEPART(week,Modifieddate) as week
-- Lấy ra giờ hiện tại bằng hàm GETDATE()
    ,GETDATE() [time_current]
FROM salesLT.Customer


-- 4. Các functions xử lí chuỗi(string)
SELECT
    ProductID
    ,Name
    ,LEN(Name) as length_name -- lấy ra độ dài của chuỗi
    ,LEFT(Name,5) as [left_5] -- lấy ra chuỗi kí tự bên trái/phải
    ,CHARINDEX('a',Name) as a_index -- Cú pháp charindex('letter',column,start_index)
    ,CHARINDEX('a',Name,CHARINDEX('a',Name)+1) as [a_index_2]
    ,SUBSTRING(name,5,6) AS plit_name -- Cú pháp cắt chuỗi với subtring(string, start location, length)
    ,REPLACE(name,'Logo','NewLogo') [newname]-- update string
FROM salesLT.Product

-- Ví dụ 1: hãy lấy ra tên người bán hàng trong cột SalesPerson
select CustomerID
    ,SalesPerson
    ,SUBSTRING(SalesPerson,CHARINDEX('\',SalesPerson)+1,LEN(SalesPerson)-CHARINDEX('\',SalesPerson)) as Name_salesperson
from salesLT.Customer

-- Ví dụ 2: 
SELECT ProductID,Name
FROM salesLT.Product

-- Ví dụ 3: logical functions
-- Case when (giống if else trong excel)
-- Cú pháp
/*Case when TH1 value_1
when TH2 value_2
when TH3 value_3
...
else value_n
END */


-- Ví dụ 3:case when
-- logic Price <100 "Thap" ; Price tu 100-1000 "trung binh" , con lai "cao"

SELECT ProductID
    , ListPrice
    , Case when ListPrice < 100 Then N'thấp'
     when ListPrice < 1000 Then N'trung bình'
     else 'cao' 
     END price_segment
from SalesLT.Product

-- Ví dụ 4: IIF_dùng khi chỉ có 2 trường hợp xảy ra( return value 1 nếu mđ đúng, return value 2 nếu mđ sai)
SELECT ProductID
    , ListPrice
    , IIF(ListPrice<100,N'thấp','cao') as price_segment
from SalesLT.Product

-- Ví dụ 4: change data type
select 'toi ten la ' + CAST(10 as varchar)
SELECT CustomerID
    , LastName
    ,CONCAT(CustomerID,':', LastName)
    ,CAST(CustomerID as varchar) + ':' + LastName
    ,CONVERT(varchar,CustomerID) + ':' + LastName
from SalesLT.Customer

-- CONVERT(new_data_type, column, [style])_ thường dùng để xử lí column dạng date/datetime
SELECT CustomerID
    ,ModifiedDate
    ,CONVERT(varchar,ModifiedDate,112) as new_date
from SalesLT.Customer
