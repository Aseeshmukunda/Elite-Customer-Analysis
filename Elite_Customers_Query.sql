-- 1. Calculate the overall average order value (AOV) across all customers
WITH Overall_AOV AS (
    SELECT 
        AVG(total_amount) AS company_wide_aov
    FROM 
        Orders
),

-- 2. Calculate the order count and average order value for each customer
Customer_Metrics AS (
    SELECT
        customer_id,
        COUNT(order_id) AS order_count,
        AVG(total_amount) AS average_order_value
    FROM
        Orders
    GROUP BY
        customer_id
)

-- 3. Select the 'Elite Customers' based on the two criteria:
--    a) order_count >= 2
--    b) average_order_value > company_wide_aov
SELECT
    cm.customer_id,
    cm.order_count,
    ROUND(cm.average_order_value, 2) AS average_order_value
FROM
    Customer_Metrics cm
CROSS JOIN
    Overall_AOV oa
WHERE
    cm.order_count >= 2
    AND cm.average_order_value > oa.company_wide_aov;
