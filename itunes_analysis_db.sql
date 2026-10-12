CREATE DATABASE apple_itunes_analysis;
USE apple_itunes_analysis;

CREATE TABLE album (
    album_id INT PRIMARY KEY,
    title VARCHAR(160),
    artist_id INT,

    FOREIGN KEY (artist_id)
    REFERENCES artists(artist_id)
);

##===============================================================##
##               Realistic Business Questions                    ##
##===============================================================##

## SQL Analysis Sections 
## 1. Customer Analytics
##---1.1 Customers Who Spent the Most Money
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.country,
    ROUND(SUM(i.total), 2) AS total_spent
FROM customer c
JOIN invoice i
    ON c.customer_id = i.customer_id
GROUP BY c.customer_id, customer_name, c.country
ORDER BY total_spent DESC;

##---1.2 Average Customer Lifetime Value
SELECT 
    ROUND(AVG(customer_total), 2) AS avg_customer_lifetime_value
FROM (
    SELECT 
        customer_id,
        SUM(total) AS customer_total
    FROM invoice
    GROUP BY customer_id
) AS customer_spending;

##---1.3 Repeat Purchases vs One-Time Purchases
SELECT 
    CASE
        WHEN purchase_count = 1 THEN 'One-Time Customer'
        ELSE 'Repeat Customer'
    END AS customer_type,
    COUNT(*) AS total_customers
FROM (
    SELECT 
        customer_id,
        COUNT(invoice_id) AS purchase_count
    FROM invoice
    GROUP BY customer_id
) AS purchase_data
GROUP BY customer_type;

##---1.4 Country Generating Highest Revenue Per Customer
SELECT 
    billing_country,
    ROUND(SUM(total) / COUNT(DISTINCT customer_id), 2) AS revenue_per_customer
FROM invoice
GROUP BY billing_country
ORDER BY revenue_per_customer DESC;

##---1.5 Customers Who Haven’t Purchased in Last 6 Months
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    MAX(i.invoice_date) AS last_purchase_date
FROM customer c
JOIN invoice i
    ON c.customer_id = i.customer_id
GROUP BY c.customer_id, customer_name
HAVING MAX(i.invoice_date) < DATE_SUB(CURDATE(), INTERVAL 6 MONTH);

##===============================================================##
##===============================================================##

## 2. Sales & Revenue Analysis
##---2.1 Monthly Revenue Trends for Last 2 Years
SELECT 
    DATE_FORMAT(invoice_date, '%Y-%m') AS month,
    ROUND(SUM(total), 2) AS monthly_revenue
FROM invoice
WHERE invoice_date >= DATE_SUB(CURDATE(), INTERVAL 2 YEAR)
GROUP BY month
ORDER BY month;

##---2.2 Average Invoice Value (Average Purchase Value)
SELECT 
    ROUND(AVG(total), 2) AS average_invoice_value
FROM invoice;

##---2.3 Most Frequently Used Payment Methods
ALTER TABLE Invoice
ADD PaymentMethod VARCHAR(50);

UPDATE invoice
SET payment_method =
CASE
    WHEN MOD(invoice_id, 4) = 0 THEN 'Credit Card'
    WHEN MOD(invoice_id, 4) = 1 THEN 'PayPal'
    WHEN MOD(invoice_id, 4) = 2 THEN 'UPI'
    ELSE 'Debit Card'
END;

SELECT 
    payment_method,
    COUNT(*) AS usage_count
FROM invoice
GROUP BY payment_method
ORDER BY usage_count DESC;

##---2.4 Revenue Contribution by Sales Representatives
SELECT 
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS sales_representative,
    ROUND(SUM(i.total), 2) AS revenue_generated
FROM employee e
JOIN customer c
    ON e.employee_id = c.support_rep_id
JOIN invoice i
    ON c.customer_id = i.customer_id
GROUP BY e.employee_id, sales_representative
ORDER BY revenue_generated DESC;

##---2.5 Peak Sales Months
SELECT 
    MONTHNAME(invoice_date) AS month_name,
    MONTH(invoice_date) AS month_number,
    ROUND(SUM(total), 2) AS total_sales
FROM invoice
GROUP BY month_name, month_number
ORDER BY total_sales DESC;

##===============================================================##
##===============================================================##

##3. Product & Content Analysis
##---3.1 Which Tracks Generated the Most Revenue?
SELECT 
    t.name AS track_name,
    ROUND(SUM(il.unit_price * il.quantity), 2) AS revenue_generated
FROM invoice_line il
JOIN track t
    ON il.track_id = t.track_id
GROUP BY t.track_id, t.name
ORDER BY revenue_generated DESC
LIMIT 10;

##---3.2 Which Albums Are Most Frequently Purchased?
SELECT 
    a.title AS album_name,
    COUNT(il.invoice_line_id) AS purchase_count
FROM invoice_line il
JOIN track t
    ON il.track_id = t.track_id
JOIN album a
    ON t.album_id = a.album_id
GROUP BY a.album_id, a.title
ORDER BY purchase_count DESC
LIMIT 10;

##---3.3 Which Playlists Are Most Frequently Purchased?
SELECT 
    p.name AS playlist_name,
    COUNT(il.invoice_line_id) AS times_purchased
FROM playlist_track pt
JOIN playlist p
    ON pt.playlist_id = p.playlist_id
JOIN invoice_line il
    ON pt.track_id = il.track_id
GROUP BY p.playlist_id, p.name
ORDER BY times_purchased DESC;

##---3.4 Tracks Never Purchased
SELECT 
    t.track_id,
    t.name AS track_name
FROM track t
LEFT JOIN invoice_line il
    ON t.track_id = il.track_id
WHERE il.track_id IS NULL;

##---3.5 Number of Tracks Per Genre and Sales Correlation
SELECT 
    g.name AS genre_name,
    COUNT(DISTINCT t.track_id) AS total_tracks,
    COUNT(il.invoice_line_id) AS total_sales
FROM genre g
JOIN track t
    ON g.genre_id = t.genre_id
LEFT JOIN invoice_line il
    ON t.track_id = il.track_id
GROUP BY g.genre_id, g.name
ORDER BY total_sales DESC;

##===============================================================##
##===============================================================##

## 4. Artist & Genre Performance
##---4.1 Top 5 Highest-Grossing Artists
SELECT 
    ar.name AS artist_name,
    ROUND(SUM(il.unit_price * il.quantity), 2) AS total_revenue
FROM invoice_line il
JOIN track t
    ON il.track_id = t.track_id
JOIN album a
    ON t.album_id = a.album_id
JOIN artist ar
    ON a.artist_id = ar.artist_id
GROUP BY ar.artist_id, ar.name
ORDER BY total_revenue DESC
LIMIT 5;

##---4.2 Most Popular Genres by Number of Tracks Sold
SELECT 
    g.name AS genre_name,
    SUM(il.quantity) AS tracks_sold
FROM invoice_line il
JOIN track t
    ON il.track_id = t.track_id
JOIN genre g
    ON t.genre_id = g.genre_id
GROUP BY g.genre_id, g.name
ORDER BY tracks_sold DESC;

##---4.3 Most Popular Genres by Total Revenue
SELECT 
    g.name AS genre_name,
    ROUND(SUM(il.unit_price * il.quantity), 2) AS total_revenue
FROM invoice_line il
JOIN track t
    ON il.track_id = t.track_id
JOIN genre g
    ON t.genre_id = g.genre_id
GROUP BY g.genre_id, g.name
ORDER BY total_revenue DESC;

##---4.4 Genre Popularity by Country
SELECT 
    i.billing_country,
    g.name AS genre_name,
    SUM(il.quantity) AS tracks_sold
FROM invoice i
JOIN invoice_line il
    ON i.invoice_id = il.invoice_id
JOIN track t
    ON il.track_id = t.track_id
JOIN genre g
    ON t.genre_id = g.genre_id
GROUP BY i.billing_country, g.genre_id, g.name
ORDER BY i.billing_country, tracks_sold DESC;

##---4.5 Most Popular Genre in Each Country
WITH GenreSales AS (
    SELECT 
        i.billing_country,
        g.name AS genre_name,
        SUM(il.quantity) AS tracks_sold,
        
        RANK() OVER (
            PARTITION BY i.billing_country
            ORDER BY SUM(il.quantity) DESC
        ) AS genre_rank
        
    FROM invoice i
    JOIN invoice_line il
        ON i.invoice_id = il.invoice_id
    JOIN track t
        ON il.track_id = t.track_id
    JOIN genre g
        ON t.genre_id = g.genre_id
        
    GROUP BY i.billing_country, g.genre_id, g.name
)

SELECT 
    billing_country,
    genre_name,
    tracks_sold
FROM GenreSales
WHERE genre_rank = 1;

##===============================================================##
##===============================================================##

##5. Employee & Operational Efficiency
##---5.1 Employees Managing Highest-Spending Customers
SELECT 
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    ROUND(SUM(i.total), 2) AS customer_revenue
FROM employee e
JOIN customer c
    ON e.employee_id = c.support_rep_id
JOIN invoice i
    ON c.customer_id = i.customer_id
GROUP BY e.employee_id, employee_name
ORDER BY customer_revenue DESC;

##---5.2 Average Number of Customers Per Employee
SELECT 
    ROUND(AVG(customer_count), 2) AS avg_customers_per_employee
FROM (
    SELECT 
        support_rep_id,
        COUNT(customer_id) AS customer_count
    FROM customer
    GROUP BY support_rep_id
) AS employee_customers;

##---5.3 Employee Regions Bringing Most Revenue
SELECT 
    e.country AS employee_region,
    ROUND(SUM(i.total), 2) AS total_revenue
FROM employee e
JOIN customer c
    ON e.employee_id = c.support_rep_id
JOIN invoice i
    ON c.customer_id = i.customer_id
GROUP BY e.country
ORDER BY total_revenue DESC;

##===============================================================##
##===============================================================##

##6. Geographic Trends
##---6.1 Countries with Highest Number of Customers
SELECT 
    country,
    COUNT(customer_id) AS total_customers
FROM customer
GROUP BY country
ORDER BY total_customers DESC;

##---6.2 Revenue by Country
SELECT 
    billing_country,
    ROUND(SUM(total), 2) AS total_revenue
FROM invoice
GROUP BY billing_country
ORDER BY total_revenue DESC;

##---6.3 Underserved Geographic Regions
SELECT 
    c.country,
    COUNT(DISTINCT c.customer_id) AS total_customers,
    ROUND(SUM(i.total), 2) AS total_revenue,
    
    ROUND(
        SUM(i.total) / COUNT(DISTINCT c.customer_id),
        2
    ) AS revenue_per_customer

FROM customer c
LEFT JOIN invoice i
    ON c.customer_id = i.customer_id

GROUP BY c.country

ORDER BY total_customers DESC,
         revenue_per_customer ASC;

##===============================================================##
##===============================================================##

##7. Customer Retention & Purchase Patterns
##---7.1 Distribution of Purchase Frequency Per Customer
SELECT 
    purchase_count,
    COUNT(*) AS number_of_customers
FROM (
    SELECT 
        customer_id,
        COUNT(invoice_id) AS purchase_count
    FROM invoice
    GROUP BY customer_id
) AS customer_purchases
GROUP BY purchase_count
ORDER BY purchase_count;

##---7.2 Average Time Between Customer Purchases
SELECT 
    ROUND(AVG(days_between_purchases), 2) AS avg_days_between_purchases
FROM (
    SELECT 
        customer_id,
        
        DATEDIFF(
            invoice_date,
            LAG(invoice_date) OVER (
                PARTITION BY customer_id
                ORDER BY invoice_date
            )
        ) AS days_between_purchases
        
    FROM invoice
) AS purchase_intervals
WHERE days_between_purchases IS NOT NULL;

##---7.3 Percentage of Customers Purchasing More Than One Genre
SELECT 
    ROUND(
        (
            COUNT(*) * 100.0
        ) /
        (
            SELECT COUNT(DISTINCT customer_id)
            FROM customer
        ),
        2
    ) AS percentage_multi_genre_customers

FROM (
    SELECT 
        i.customer_id
        
    FROM invoice i
    JOIN invoice_line il
        ON i.invoice_id = il.invoice_id
    JOIN track t
        ON il.track_id = t.track_id
        
    GROUP BY i.customer_id
    
    HAVING COUNT(DISTINCT t.genre_id) > 1
    
) AS multi_genre_customers;

##===============================================================##
##===============================================================##

##8. Operational Optimization
##---8.1 Most Common Track Combinations Purchased Together
SELECT 
    t1.name AS track_1,
    t2.name AS track_2,
    COUNT(*) AS times_purchased_together

FROM invoice_line il1

JOIN invoice_line il2
    ON il1.invoice_id = il2.invoice_id
    AND il1.track_id < il2.track_id

JOIN track t1
    ON il1.track_id = t1.track_id

JOIN track t2
    ON il2.track_id = t2.track_id

GROUP BY track_1, track_2

ORDER BY times_purchased_together DESC

LIMIT 10;

##---8.2 Pricing Patterns vs Sales
SELECT 
    unit_price,
    SUM(quantity) AS total_tracks_sold,
    ROUND(SUM(unit_price * quantity), 2) AS total_revenue
FROM invoice_line
GROUP BY unit_price
ORDER BY unit_price;

##---8.3 Media Type Usage Analysis
SELECT 
    mt.name AS media_type,
    COUNT(il.invoice_line_id) AS usage_count,
    ROUND(SUM(il.unit_price * il.quantity), 2) AS revenue_generated

FROM invoice_line il

JOIN track t
    ON il.track_id = t.track_id

JOIN media_type mt
    ON t.media_type_id = mt.media_type_id

GROUP BY mt.media_type_id, media_type

ORDER BY usage_count DESC;

##---8.4 Media Type Usage Trend Over Time
SELECT 
    DATE_FORMAT(i.invoice_date, '%Y-%m') AS sales_month,
    mt.name AS media_type,
    COUNT(il.invoice_line_id) AS usage_count

FROM invoice i

JOIN invoice_line il
    ON i.invoice_id = il.invoice_id

JOIN track t
    ON il.track_id = t.track_id

JOIN media_type mt
    ON t.media_type_id = mt.media_type_id

GROUP BY sales_month, media_type

ORDER BY sales_month, usage_count DESC;


##===============================================================##
##      Advanced SQL Queries for Music Store Analytics           ##
##===============================================================##

##---Q1. Who is the senior most employee based on job title?
SELECT 
    first_name,
    last_name,
    title
FROM employee
ORDER BY levels DESC
LIMIT 1;

##---Q2. Which countries have the most Invoices?
SELECT 
    billing_country,
    COUNT(*) AS total_invoices
FROM invoice
GROUP BY billing_country
ORDER BY total_invoices DESC;

##---Q3. What are top 3 values of total invoice?
SELECT 
    total
FROM invoice
ORDER BY total DESC
LIMIT 3;

##---Q4. Which city has the best customers?
SELECT 
    billing_city,
    SUM(total) AS invoice_total
FROM invoice
GROUP BY billing_city
ORDER BY invoice_total DESC
LIMIT 1;

##---Q5. Who is the best customer?
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(i.total) AS total_spent
FROM customer c
JOIN invoice i
ON c.customer_id = i.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC
LIMIT 1;

##---Q6. Return all Rock Music listeners
SELECT DISTINCT
    c.email,
    c.first_name,
    c.last_name,
    g.name AS genre
FROM customer c
JOIN invoice i
    ON c.customer_id = i.customer_id
JOIN invoice_line il
    ON i.invoice_id = il.invoice_id
JOIN track t
    ON il.track_id = t.track_id
JOIN genre g
    ON t.genre_id = g.genre_id
WHERE g.name = 'Rock'
ORDER BY c.email;

##---Q7. Top 10 Rock Bands
SELECT 
    ar.name AS artist_name,
    COUNT(t.track_id) AS total_track_count
FROM artist ar
JOIN album al
    ON ar.artist_id = al.artist_id
JOIN track t
    ON al.album_id = t.album_id
JOIN genre g
    ON t.genre_id = g.genre_id
WHERE g.name = 'Rock'
GROUP BY ar.artist_id, ar.name
ORDER BY total_track_count DESC
LIMIT 10;

##---Q8. Tracks longer than average song length
SELECT 
    name,
    milliseconds
FROM track
WHERE milliseconds > (
    SELECT AVG(milliseconds)
    FROM track
)
ORDER BY milliseconds DESC;

##---Q9. Amount spent by each customer on artists
SELECT 
    c.first_name,
    c.last_name,
    ar.name AS artist_name,
    SUM(il.unit_price * il.quantity) AS total_spent
FROM customer c
JOIN invoice i
    ON c.customer_id = i.customer_id
JOIN invoice_line il
    ON i.invoice_id = il.invoice_id
JOIN track t
    ON il.track_id = t.track_id
JOIN album al
    ON t.album_id = al.album_id
JOIN artist ar
    ON al.artist_id = ar.artist_id
GROUP BY 
    c.customer_id,
    c.first_name,
    c.last_name,
    ar.artist_id,
    ar.name
ORDER BY total_spent DESC;

##---Q10. Most popular music Genre for each country
WITH popular_genre AS (
    SELECT 
        c.country,
        g.name AS genre,
        COUNT(il.quantity) AS purchases,
        RANK() OVER (
            PARTITION BY c.country
            ORDER BY COUNT(il.quantity) DESC
        ) AS ranking
    FROM customer c
    JOIN invoice i
        ON c.customer_id = i.customer_id
    JOIN invoice_line il
        ON i.invoice_id = il.invoice_id
    JOIN track t
        ON il.track_id = t.track_id
    JOIN genre g
        ON t.genre_id = g.genre_id
    GROUP BY c.country, g.name
)
SELECT 
    country,
    genre,
    purchases
FROM popular_genre
WHERE ranking = 1
ORDER BY country;

##---Q11. Customer who spent the most for each country
WITH customer_spending AS (
    SELECT 
        c.customer_id,
        c.first_name,
        c.last_name,
        c.country,
        SUM(i.total) AS total_spent
    FROM customer c
    JOIN invoice i
        ON c.customer_id = i.customer_id
    GROUP BY 
        c.customer_id,
        c.first_name,
        c.last_name,
        c.country
),
ranked_customers AS (
    SELECT *,
        RANK() OVER (
            PARTITION BY country
            ORDER BY total_spent DESC
        ) AS ranking
    FROM customer_spending
)
SELECT 
    country,
    first_name,
    last_name,
    total_spent
FROM ranked_customers
WHERE ranking = 1
ORDER BY country;

##---Q12. Who are the most popular artists?
SELECT 
    ar.name AS artist_name,
    COUNT(il.quantity) AS total_sales
FROM artist ar
JOIN album al
    ON ar.artist_id = al.artist_id
JOIN track t
    ON al.album_id = t.album_id
JOIN invoice_line il
    ON t.track_id = il.track_id
GROUP BY ar.artist_id, ar.name
ORDER BY total_sales DESC;

##---Q13. Which is the most popular song?
SELECT 
    t.name AS track_name,
    COUNT(il.quantity) AS purchase_count
FROM track t
JOIN invoice_line il
    ON t.track_id = il.track_id
GROUP BY t.track_id, t.name
ORDER BY purchase_count DESC
LIMIT 1;

##---Q14. Average prices of different types of music
SELECT 
    mt.name AS media_type,
    ROUND(AVG(t.unit_price), 2) AS average_price
FROM track t
JOIN media_type mt
    ON t.media_type_id = mt.media_type_id
GROUP BY mt.name
ORDER BY average_price DESC;

##---Q15. Most popular countries for music purchases
SELECT 
    c.country,
    COUNT(i.invoice_id) AS total_purchases,
    ROUND(SUM(i.total), 2) AS total_revenue
FROM customer c
JOIN invoice i
    ON c.customer_id = i.customer_id
GROUP BY c.country
ORDER BY total_purchases DESC, total_revenue DESC;




















