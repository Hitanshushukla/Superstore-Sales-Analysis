/*created a cleaned view */
CREATE VIEW superstore AS 
SELECT sc.row_id,
       sc.order_id,
       str_to_date(sc.order_date,'%d-%m-%Y') AS orderDate,
       sc.customer_id,
       sc.segment,
       sc.country,
       sc.city,
       sc.state,
       sc.region,
       sc.product_id,
       sc.category,
       sc.product_name,
       CAST(sc.sales AS decimal(10,2)) AS Sales,
       sc.quantity,
       CAST(REPLACE(sc.discount,'%','') AS decimal(5,2))/100 AS Discount,
       CAST(sc.profit AS decimal(5,2)) AS Profit
FROM superstore_cleaned sc; 

/*total revenue */
SELECT round(SUM(s.Sales))
FROM superstore s; 

/*profit*/
SELECT round(sum(s.Profit ))
FROM superstore s ;

/*quantity sold*/
SELECT sum(s.quantity ) 
FROM superstore s ; 

/*average order value*/ 
SELECT round(sum(s.Sales)/COUNT(DISTINCT s.order_id )) 
FROM superstore s ;

/*yearly trend sales and profit*/
SELECT replace(YEAR(s.orderDate ),',','') AS YEAR ,
       round(sum(s.Sales )) AS revenue,
       round(sum(s.Profit )) AS profit 
FROM superstore s 
GROUP BY `year` 
ORDER BY revenue DESC 

/*monthly sales trend*/
SELECT MONTHNAME(s.orderDate ) AS MONTH,
       round(sum(s.Sales )) AS revenue ,
       round(sum(s.Profit)) AS profit
FROM superstore s
WHERE year(s.orderDate ) = 2017 
GROUP BY `month` 
ORDER BY revenue DESC 

/*region analysis*/
SELECT s.region,
       round(sum(s.Sales)) AS revenue,
       round(sum(s.Profit)) AS profit
FROM superstore s 
GROUP BY s.region 
ORDER BY revenue DESC 

/*category analysis*/
SELECT s.category, 
      round(sum(s.Sales)) AS revenue,
       round(sum(s.Profit )) AS profit
FROM superstore s 
GROUP BY s.category 
ORDER BY revenue  DESC 

/*top 10 products by revenue */
SELECT s.product_name ,
       s.category ,
      round(sum(s.Sales)) AS revenue 
FROM superstore s 
GROUP BY product_name , s.category  
ORDER BY revenue 

/*top 10 products by profit */
SELECT s.product_name ,
       s.category ,
       round(sum(s.Profit)) AS profit
FROM superstore s 
GROUP BY s.product_name ,s.category  
ORDER BY profit DESC 
LIMIT 10










