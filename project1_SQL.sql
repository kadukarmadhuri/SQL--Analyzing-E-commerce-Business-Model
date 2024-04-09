/* Business model Customer to Customer (C2C) allows customers to do business with each other. 
This model is growing fast with e-commerce platforms where sellers may be required to pay some amount and buyer can buy it without 
paying anything. E-Commerce website brings the seller and buyer to the same platform. 

Analyzing the user's database will lead to understanding the business perspective. 
Behaviour of the users can be traced in terms of business with exploration of the user’s database. 

Dataset: One .csv file with name users_data with 98913 rows and 27 columns */

-- 1. Create new schema as ecommerce
CREATE DATABASE ecommerce;

-- 2.  Import .csv file users_data into MySQL
-- (right click on ecommerce schema -> Table Data import Wizard -> Give path of the file -> Next -> choose options : Create a new table ,
--  select delete if exist -> next -> next

USE ecommerce;

SELECT * FROM users_data;

-- 3. Run SQL command to see the structure of table

DESC users_data;

-- 4. Run SQL command to select first 100 rows of the database

SELECT 
    *
FROM
    users_data
LIMIT 100;

-- 5. How many distinct values exist in table for field country and language

SELECT 
    COUNT(DISTINCT country), COUNT(DISTINCT language)
FROM
    users_data;

-- 6. Check whether male users are having maximum followers or female users.

SELECT 
    gender, SUM(socialNbFollowers)
FROM
    users_data
GROUP BY gender;

/* 7. Calculate the total users those
a. Uses Profile Picture in their Profile
b. Uses Application for Ecommerce platform
c. Uses Android app
d.Uses ios app */

-- a. Uses Profile Picture in their Profile
SELECT
 'Profilepicture' AS 'category',COUNT(hasProfilePicture) TOTAL_Users
FROM
users_data
WHERE
hasProfilePicture = 'TRUE'
UNION 
SELECT
'Any APP',COUNT(hasAnyApp)
FROM
users_data
WHERE
hasAnyApp = 'TRUE'
UNION
SELECT
'Andriod App',COUNT(hasAndroidApp) 
FROM
users_data
WHERE
hasAndroidApp = 'TRUE'
UNION
SELECT
'Ios APP',COUNT(hasIosApp)
FROM
users_data
WHERE
hasIosApp = 'TRUE';


-- 8. Calculate the total number of buyers for each country and sort the result in descending order of
-- total number of buyers. (Hint: consider only those users having at least 1 product bought.)

SELECT * FROM users_data;
SELECT 
    country, COUNT(productsBought) Total_number_of_buyers
FROM
    users_data
WHERE
    productsBought > 0
GROUP BY country
ORDER BY COUNT(productsBought) DESC; 

-- 9. Calculate the total number of sellers for each country and sort the result in ascending order of
-- total number of sellers. (Hint: consider only those users having at least 1 product sold.)
SELECT 
    country, COUNT(productsSold) productsSold
FROM
    users_data
WHERE
    productsSold >= 1
GROUP BY country
ORDER BY COUNT(productsSold) ASC;

-- 10. Display name of top 10 countries having maximum products pass rate.
SELECT 
    country, COUNT(productsPassRate) productsPassRate
FROM
    users_data
GROUP BY country
ORDER BY COUNT(productsPassRate) DESC LIMIT 10;

-- 11. Calculate the number of users on an ecommerce platform for different language choices.

SELECT language,COUNT(language) FROM users_data GROUP BY language;

-- 12. Check the choice of female users about putting the product in a wishlist or to like socially on an
-- ecommerce platform. (Hint: use UNION to answer this question.)
SELECT * FROM users_data;
SELECT 
    'Product_Wished' AS 'Female Choices', SUM(productsWished) SUM
FROM
    users_data
WHERE
    gender = 'F' 
UNION SELECT 
    'product_liked', SUM(socialProductsLiked)
FROM
    users_data
WHERE
    gender = 'F';
    
-- From The data it is clear that the Female users  chose to like the product more
    
-- 13. Check the choice of male users about being seller or buyer. (Hint: use UNION to solve this question.)
SELECT * FROM users_data;
SELECT 
    'productsSold', SUM(productsSold) SUM
FROM
    users_data
WHERE
    gender = 'M' 
UNION SELECT 
    'productsBought', SUM(productsBought)
FROM
    users_data
WHERE
    gender = 'M';

-- From The data it is clear that the Male users are chose to be the buyers more

-- 14. Which country is having maximum number of buyers?
SELECT 
    country, SUM(productsBought)
FROM
    users_data
GROUP BY country
ORDER BY SUM(productsBought) DESC
LIMIT 1; 

-- FRANCE

-- 15. List the name of 10 countries having zero number of sellers.
SELECT 
    country, productsSold
FROM
    users_data
WHERE
    productsSold = 0
GROUP BY country
LIMIT 10;

-- 16. Display record of top 110 users who have used ecommerce platform recently.

SELECT 
    *
FROM
    users_data
ORDER BY daysSinceLastLogin ASC
LIMIT 110;

-- 17. Calculate the number of female users those who have not logged in since last 100 days.

SELECT 
    gender, COUNT(gender) No_of_Females
FROM
    users_data
WHERE
    gender = 'F'
        AND daysSinceLastLogin >= 100;

-- 18. Display the number of female users of each country at ecommerce platform.

SELECT 
    country, gender, COUNT(gender) No_of_Females
FROM
    users_data
WHERE
    gender = 'F'
GROUP BY country;

-- 19. Display the number of male users of each country at ecommerce platform.

SELECT 
    country, gender, COUNT(gender) No_of_Males
FROM
    users_data
WHERE
    gender = 'M'
GROUP BY country;

-- 20. Calculate the average number of products sold and bought on ecommerce platform by male users for each country.

SELECT 
    country,
    gender,
    AVG(productsSold) AVG_productsSold,
    AVG(productsBought) AVG_productsBought
FROM
    users_data
WHERE
    gender = 'M'
GROUP BY country;