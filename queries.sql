SELECT Category, ROUND(SUM(Sales), 2) AS Total_Sales
FROM sales
GROUP BY Category
ORDER BY Total_Sales DESC;




SELECT TOP 5 Product_Name, ROUND(SUM(Sales), 2) AS Total_Sales
FROM sales
GROUP BY Product_Name
ORDER BY Total_Sales DESC;




SELECT YEAR(Order_Date) AS Yr,
       MONTH(Order_Date) AS Mo,
       ROUND(SUM(Sales), 2) AS Total_Sales
FROM sales
GROUP BY YEAR(Order_Date), MONTH(Order_Date)
ORDER BY Yr, Mo;





SELECT Segment,
       COUNT(DISTINCT Order_ID) AS Orders,
       ROUND(SUM(Sales) / COUNT(DISTINCT Order_ID), 2) AS Avg_Order_Value
FROM sales
GROUP BY Segment;




WITH ProductSales AS (
    SELECT Category, Product_Name, SUM(Sales) AS Total_Sales
    FROM sales
    GROUP BY Category, Product_Name
),
Ranked AS (
    SELECT Category, Product_Name, ROUND(Total_Sales, 2) AS Total_Sales,
           RANK() OVER (PARTITION BY Category ORDER BY Total_Sales DESC) AS Rnk
    FROM ProductSales
)
SELECT Category, Product_Name, Total_Sales
FROM Ranked
WHERE Rnk <= 3;