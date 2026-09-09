CREATE DATABASE
Dataco_SupplyChain;

USE Dataco_SupplyChain;

SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES;

SELECT TOP 50 * FROM Dataco_cleaned2;

----TOTAL SALES
SELECT SUM(Sales) AS Total_Sales  -----3678435.0130577
FROM Dataco_cleaned2

--TOTAL PROFIT
SELECT SUM([Order_Profit_Per_Order]) AS Total_Profit    ------3966902.9739931
FROM Dataco_cleaned2;

--Average Profit Per Oreder
SELECT AVG([Order_Profit_Per_Order])   ---21.97498827
AS Avg_Profit_Per_Order
FROM Dataco_cleaned2;

--Total Units Sold
SELECT SUM([Order_Item_Quantity]) AS Total_Units_Sold-----384079
FROM Dataco_cleaned2;

--Average_Order_Value                              
SELECT AVG([Order_Item_Total]) AS Avg_Order_Value  ---183.107608507113
FROM Dataco_cleaned2;


--Sales By Category
SELECT [Category_Name],
SUM(Sales) AS Total_Sales   -- Total 50 category -Fishing           6929653.69033813
FROM Dataco_cleaned2                            --Cleats            4431942.78317261
GROUP BY Category_Name                          --Camping & Hiking	4118425.5708313
ORDER BY Total_Sales DESC;                      --Cardio Equipment	3694843.1966629 
                                                --Women's Apparel	3147800

--Profit by Category
SELECT [Category_Name],
SUM(Order_Profit_Per_Order) AS Total_Profit   -- Total 50 category --Fishing            756220.76718092
FROM Dataco_cleaned2                                              --Cleats              494636.919777095
GROUP BY Category_Name                                            --Camping & Hiking    427455.568096399
ORDER BY Total_Profit DESC;                                       --Cardio Equipment    383011.098489463
                                                                  --Women's Apparel     350421.02956143

--Sales By Market                        --Europe        10872396.7955751
SELECT Market,                           --LATAM	     10277612.8408318
SUM(Sales) AS Total_Sales                --Pacific Asia	 8273743.74056339
FROM Dataco_cleaned2                     --USCA	         5066528.7109108
GROUP BY Market                          --Africa	     2294452.92517662
ORDER BY Total_Sales DESC;


--Sales by Segment Segment
SELECT Customer_Segment,                 --Home Office	6520538.01515675
SUM(Sales) AS Total_Sales                --Corporate	11168406.8428955
FROM Dataco_cleaned2                     --Consumer	    19095790.1550055
GROUP BY Customer_Segment
ORDER BY Total_Sales;

--Shipping Performance
SELECT 
Shipping_Mode,                                                                     
AVG(CAST(Days_for_shipping_real AS DECIMAL(6,2))) AS Avg_Actual_Days,              --Second Class    3.990828 	    2.000000	1.990828	76.632780554293
AVG(CAST(Days_for_shipment_scheduled AS DECIMAL(10,2))) AS Avg_Scheduled_Days,     --First Class     2.000000	    1.000000	1.000000	95.322499460703
AVG(CAST(Days_for_shipping_real AS DECIMAL(10,2))                                  --Same Day	     0.478278	    0.000000	0.478278	45.743042004724
        - CAST(Days_for_shipment_scheduled AS DECIMAL(10,2))) AS Avg_Delay,        --Standard Class	 3.995907	    4.000000	-0.004092	38.071683124211
(SUM(CAST(Late_delivery_risk AS INT)) * 100.0 / COUNT(*)) AS Late_Delivery_Risk_Percentage
FROM Dataco_cleaned2
GROUP BY Shipping_Mode
ORDER BY Avg_Delay DESC;


--Order Status
SELECT Order_Status,       --COMPLETE	        59491           ON_HOLD	            9804
COUNT(*) AS Order_Counts   --PENDING_PAYMENT	39832           SUSPECTED_FRAUD 	4062
FROM Dataco_cleaned2       --PROCESSING	        21902           CANCELED	        3692
GROUP BY Order_Status      --PENDING	        20227           PAYMENT_REVIEW	    1893
ORDER BY Order_Counts DESC;--CLOSED	            19616


--Yearly Sales
SELECT YEAR(order_date_DateOrders) AS Order_Year,  --2015	12340831.4307594
SUM(Sales) AS Total_Sales                          --2016	12303817.3242435
FROM Dataco_cleaned2                               --2017	11808436.1428852
GROUP BY YEAR(order_date_DateOrders)               --2018	331650.115169525 (in this only jan is only their)
ORDER BY Total_Sales DESC;


--Category Profitibility Analysis/profit margin by category
SELECT Category_Name,SUM(Sales) AS Total_Sales,                                            
SUM(Order_Profit_Per_Order) AS Total_Profit,                                               --Golf Bags & Carts	    10369.390335083	    1810.06999254227    17.46
ROUND(SUM(Order_Profit_Per_Order) * 100/NULLIF(SUM(Sales),0),2) AS Profit_Margin_Percentage--Fitness Accessories	35601.4405479431	5258.39001595974	14.77
FROM Dataco_cleaned2                                                                       --Toys                   6104.65997982025    900.710000380874    14.75
GROUP BY Category_Name                                                                     --Soccer	                26477.0498352051	3901.94995319843    14.74
ORDER BY Profit_Margin_Percentage DESC;                                                    --Women's Clothing	    140283.004760742	19102.8499311209	13.62
                                                                                           --Baseball & Softball	94057.152545929 	12762.1300672293	13.57

--Late Delivery by Market
SELECT Market,                                                                                                 --Africa	        11614 	6340	54
COUNT(*) AS Total_Orders,                                                                                      --LATAM	        51594	28044	54
SUM(CASE WHEN Late_delivery_risk = 1 THEN 1 ELSE 0 END) AS Late_Order,                                         --USCA	        25799	14138	54
ROUND(SUM(CASE WHEN Late_delivery_risk = 1 THEN 1 ELSE 0 END) * 100 / COUNT(*), 2) AS late_delivery_percentage --Pacific Asia	41260	22712	55
FROM Dataco_cleaned2
GROUP BY Market                                                                                                -- Europe	    50252	27743	55
ORDER BY Late_delivery_percentage

--Profit Margin by Markrt                                                                      --Sales                     Profit    Profit Margin Percentage
SELECT Market,                                                                                 --8273743.74056339	857753.441097483	10.37
    SUM(Sales) AS Total_Sales,                                                                 --10872396.7955751	1169442.96097703	10.76
    SUM(Order_Profit_Per_Order) AS Total_Profit,                                               --10277612.8408318	1123321.61147487	10.93
    ROUND(SUM(Order_Profit_Per_Order) * 100 /NULLIF(SUM(Sales),0),2) AS Profit_Margin_Percentage--2294452.92517662	252071.180070952	10.99
FROM Dataco_cleaned2                                                                           --5066528.7109108	564313.780372769	11.14
GROUP BY Market
ORDER BY Profit_Margin_Percentage;

                                                                                                   --Region             sales                Profit             Profit_Margin
--Region Profitability  ( TOP 8)                                                                   --Southern Africa	228251.594503403	30826.0501462817	13.51
SELECT Order_Region,                                                                               --Canada	            186861.043571472	23900.7099590898	12.79
    SUM(Sales) AS Total_Sales,                                                                     --Central Asia	    109839.932195663	13045.2800508738	11.88
    SUM(Order_Profit_Per_Order) AS Total_Profit,                                                   --East Africa	    376234.897478104	43167.729926914	    11.47
    ROUND(SUM(Order_Profit_Per_Order) *100 / NULLIF(SUM(Sales),0),2) AS Profit_Percentage_margin   --East of USA	    1371111.98700333	156263.300190404	11.4
FROM Dataco_cleaned2                                                                               --US Center 	        1151355.77331543	131094.229873374	11.39
GROUP BY Order_Region                                                                              --South America	    2960881.40759659	335154.400813699	11.32
ORDER BY Profit_Percentage_margin DESC;                                                            --Southern Europe	2047918.81686783	230829.229880176	11.27


--Delivery Performance By Region(TOP 8)                         --Order_Region    Total_Orders   Late_Records    Late_Delivery_Percentage
SELECT Order_Region,                                            --Central Africa	    1677	       972          	57
COUNT(*) AS Total_Orders,                                       --South Asia         	7731	       4350	            56
SUM(CASE WHEN Late_delivery_risk = 1 THEN 1                     --Central Asia         	553            306	            55
ELSE 0 END) AS Late_Records,                                    --East of USA	        6915	       3849	            55
ROUND(SUM(CASE WHEN Late_delivery_risk = 1 THEN 1               --Western Europe	    27109	       15140	        55
ELSE 0 END) * 100 / COUNT(*),2) AS Late_Delivery_Percentage     --West Asia	            6009	       3322	            55
FROM Dataco_cleaned2                                            --East Africa	        1852	       1036	            55
GROUP BY Order_Region                                           --US Center 	        5887	       3252	            55
ORDER BY Late_Delivery_Percentage DESC;                         --Southeast Asia	    9539	       5297	            55


--Actual vs Seheduled Delivery Gap                                                                                               --Shipping_Mode     Avg_Delivery_Gap
SELECT Shipping_Mode,                                                                                                            --Second Class	     1.990828
AVG(CAST(Days_for_shipping_real AS DECIMAL(10,2)) - CAST(Days_for_shipment_scheduled AS DECIMAL(10,2))) AS Average_Delivery_Gap  --First Class	     1.000000
FROM Dataco_cleaned2                                                                                                             --Same Day          0.478278
GROUP BY Shipping_Mode                                                                                                           --Standard Class	-0.004092
ORDER BY Average_Delivery_Gap DESC;                                                                                              

--Country Profitability
SELECT Order_Country,
SUM(Sales) AS Total_Sales,
SUM(Order_Profit_Per_Order) AS Total_Profit,
ROUND(SUM(Order_Profit_Per_Order) * 100 / NULLIF(SUM(Sales),0),2) AS Profit_Margin_Analysis
FROM Dataco_cleaned2
GROUP BY Order_Country
ORDER BY Profit_Margin_Analysis DESC;


--Customer Segment Profitability                                                                   --Customer Segment   Orders    Sales           Profit            Profit_Margin
SELECT Customer_Segment,                                                                           --Home Office	     32226	 6520538.01515675	690840.340618819	10.59
    COUNT(*) AS Total_Orders,                                                                      --Corporate	         54789	 11168406.8428955	1202574.96148442	10.77
    SUM(Sales) AS Total_Sales,                                                                     --Consumer	         93504   19095790.1550055	2073487.67188986	10.86
    SUM(Order_Profit_Per_Order) AS Total_Profit,
    ROUND(SUM(Order_Profit_Per_Order) *100 / NULLIF(SUM(Sales),0) ,2) AS Profit_Margin_Percentage
FROM Dataco_cleaned2
GROUP BY Customer_Segment
Order by Profit_Margin_Percentage DESC

--Discount And Profitability Analysis
SELECT CASE WHEN (Order_Profit_Per_Order) = 0 THEN 'No Discount'
            WHEN (Order_Profit_Per_Order) <= 0.10 THEN '0-10%'        --Group       Sales               Order   Profit
            WHEN (Order_Profit_Per_Order) <= 0.20 THEN '10-20%'       --20-25%	    29682347.2875023	145544	7850448.55977757
            ELSE '20-25%'                                             --10-20%	    173.309998512268	13	    1.68000001460314
            END AS Discount_Band,                                     --No Discount	232031.084320068	1177	0
     SUM(Sales) AS Total_Sales,                                       --0-10%	    6870183.33123684	33785	-3883547.26578449
     COUNT(*) AS Total_Order,
     SUM(Order_Profit_Per_Order) AS Total_Profit
     FROM Dataco_cleaned2
     GROUP BY CASE WHEN (Order_Profit_Per_Order) = 0 THEN 'No Discount'
            WHEN (Order_Profit_Per_Order) <= 0.10 THEN '0-10%'
            WHEN (Order_Profit_Per_Order) <= 0.20 THEN '10-20%'
            ELSE '20-25%'
            END
    ORDER BY Total_Profit DESC;


--Top 10 Produts by Profit                  --Field & Stream Sportsman 16 Gun Fire Safe	        6929653.69033813	756220.76718092
SELECT TOP 10                               --Perfect Fitness Perfect Rip Deck	                4421143.14352417	493828.299768627
Product_Name,                               --Diamondback Women's Serene Classic Comfort Bi 	4118425.5708313 	427455.568096399
Sum(Sales) AS Total_Sales,                  --Nike Men's Free 5.0+ Running Shoe	                3667633.1966629	    379915.818508208
SUM(Order_Profit_Per_Order) AS Total_Profit --Nike Men's Dri-FIT Victory Golf Polo           	3147800	            350421.02956143
FROM Dataco_cleaned2                        --Pelican Sunstream 100 Kayak	                    3099845.08514404	324076.37001729
GROUP BY Product_Name                       --O'Brien Men's Neoprene Life Vest              	2888993.91355896	318451.430549145
ORDER BY Total_Profit DESC;                 --Nike Men's CJ Elite 2 TD Football Cleat	        2891757.66220093	311902.820203662


--Order With Negative Profit/Loss Making Categories          --Fishing	3209	-728570.946085691              ALL CATEGORY HAS SOME LOSS BUT THESE ARE THE HIGEST LOSS
SELECT Category_Name,                                        --Cleats	4590	-452594.210420907
COUNT(*) AS Total_Orders,                                    --Camping & Hiking	2590	-443082.231184006
SUM(Order_Profit_Per_Order) AS Total_Loss                    --Cardio Equipment	2332	-402647.258937359
FROM Dataco_cleaned2                                         --Water Sports	2924	-334569.630045176
WHERE [Order_Profit_Per_Order] < 0                           --Women's Apparel	3923	-323772.870212257
GROUP BY Category_Name                                       --Men's Footwear	4169	-309269.699739695
ORDER BY Total_Loss ASC;                                     --Indoor/Outdoor Games	3617	-298637.479500383


--Order Status + Probitability                                                                  --Order_Status   Total_Records   Sales  Profit      Profit Margin
SELECT                                                                                          --COMPLETE	      59491	        12095314.9507427	1321735.75117999	10.93
    Order_Status,                                                                               --PENDING_PAYMENT 39832	        8106697.55521965	843810.240919173	10.41
    COUNT(*) AS Total_Records,                                                                  --PROCESSING	  21902	        4504063.74611092	494825.87078394	10.99
    SUM(Sales) AS Total_Sales,                                                                  --CLOSED	      19616     	4022624.16666603	457981.090591289	11.39
    SUM(Order_Profit_Per_Order) AS Total_Profit,                                                --PENDING	      20227     	4120532.86946869	435725.850059211	10.57
    ROUND(SUM(Order_Profit_Per_Order) * 100 / NULLIF(SUM(Sales),0),2) AS Profit_Margin_Analysis --ON_HOLD	      9804	        1981542.70798683	208913.040198147	10.54  
FROM Dataco_cleaned2                                                                            --SUSPECTED_FRAUD 4062	        825934.955774307	85136.7100365162	10.31
GROUP BY Order_Status                                                                           --CANCELED	      3692          744370.40411377	    75345.6301435083	10.12
ORDER BY Total_Profit DESC;                                                                     --PAYMENT_REVIEW  1893       	383653.656974792	43428.7900813222	11.32
                                                                        
--Top 3 Product Within Each category
WITH ProductSales AS (
    SELECT
        Category_Name,
        Product_Name,
        SUM(Sales) AS Total_Sales,
        ROW_NUMBER() OVER( PARTITION BY Category_Name ORDER BY SUM(Sales) DESC ) AS Product_Rank
    FROM Dataco_cleaned2
    GROUP BY Category_Name,Product_Name
)
SELECT 
    Category_Name,
    Product_Name,
    Total_Sales,
    Product_Rank
FROM ProductSales
WHERE Product_Rank <= 3
ORDER BY Category_Name,Product_Rank


--Year to Year Sales
WITH YearlySales AS(
    SELECT
        YEAR(Order_date_DateOrders) AS Order_Year,
        SUM(Sales) AS Total_Sales
FROM Dataco_cleaned2
GROUP BY YEAR(Order_date_DateOrders)
)
   SELECT
       Order_Year,
       Total_Sales,
       LAG(Total_Sales) OVER (ORDER BY Order_Year) AS Previous_Year_Sales,
       ROUND(((Total_Sales - LAG(Total_Sales) OVER(ORDER BY Order_Year))* 100) /NULLIF(LAG(Total_Sales) OVER (ORDER BY Order_Year),0),2) AS YOY_Growth_Percentage
   FROM YearlySales
   ORDER BY Order_Year;


--MOM Sales Analysis
WITH MONTHLYSALES AS(
    SELECT 
        YEAR(Order_date_DateOrders) AS Order_Year,
        MONTH(Order_date_DateOrders) AS Order_Month,
        SUM(Sales) AS Total_Sales
    FROM Dataco_cleaned2
    GROUP BY YEAR(Order_date_DateOrders),
    MONTH(Order_date_DateOrders)
)
   SELECT 
       Order_Year,
       Order_Month,
       Total_Sales,
       LAG(Total_Sales) OVER(ORDER BY Order_Year,Order_Month) AS Previous_Month_Sales,
       ROUND(((Total_Sales - LAG(Total_Sales) OVER(ORDER BY Order_Year,Order_Month)) * 100) / NULLIF(LAG(Total_Sales) OVER(ORDER BY Order_Year,Order_Month),0),2) AS MONTHLY_Growth_Percentage
   FROM MONTHLYSALES
   ORDER BY Order_Year,
   Order_Month;

--JANUARY VS JANUARY ANALYSIS
SELECT
    YEAR(Order_date_DateOrders) AS Order_Year,
    SUM(Sales) AS Total_Sales,
    LAG(SUM(Sales)) OVER(ORDER BY YEAR(Order_date_DateOrders)) AS Previous_Month,
    ROUND(((SUM(Sales) - LAG(SUM(Sales)) OVER(ORDER BY YEAR(Order_date_DateOrders)))* 100) / NULLIF(LAG(SUM(Sales)) OVER(ORDER BY YEAR(Order_date_DateOrders)),0),2) AS Monthly_Percentage
FROM Dataco_cleaned2
WHERE MONTH(Order_date_DateOrders) = 1
GROUP BY YEAR(Order_date_DateOrders)
ORDER BY Order_Year;


--Important KPIs
SELECT SUM(Sales) AS Total_Sales,                --total sales =     36784735.0130577
SUM(Order_Profit_Per_Order) AS Total_Profit,     --total profit =    3966902.9739931
COUNT(DISTINCT (Order_Id)) AS Total_Order,       --total order =     65752
COUNT(DISTINCT(Customer_Id)) AS Total_Customer,  --total customer =  20652
SUM(Order_Item_Quantity) AS Total_Units_Sold     --total units sold =384079
FROM Dataco_cleaned2;


SELECT
AVG(Order_Item_Discount_Rate) * 100
FROM Dataco_cleaned2;

SELECT
AVG(Order_Profit_Per_Order) 
FROM Dataco_cleaned2;

SELECT
ROUND(SUM(CASE WHEN Late_delivery_risk = 0 THEN 1 ELSE 0 END) * 100 /COUNT(*),2) 
FROM Dataco_cleaned2


SELECT Shipping_Mode,
COUNT(*) AS Total_order,
SUM(CASE WHEN [Days_for_shipping_real] >[Days_for_shipment_scheduled] THEN 1 ELSE 0 END)AS Late_Orders,
ROUND(SUM(CASE WHEN [Days_for_shipping_real] >[Days_for_shipment_scheduled] THEN 1 ELSE 0 END) *100 /COUNT(*),2)
FROM Dataco_cleaned2
GROUP BY Shipping_Mode


SELECT COLUMN_NAME, DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Dataco_cleaned2';

select * from Dataco_clea