-- ### App Trader

-- Your team has been hired by a new company called App Trader to help them explore and gain insights from apps that are made available through the Apple App Store and Android Play Store. App Trader is a broker that purchases the rights to apps from developers in order to market the apps and offer in-app purchase. 

-- Unfortunately, the data for Apple App Store apps and Android Play Store Apps is located in separate tables with no referential integrity.

-- #### 2. Assumptions

-- Based on research completed prior to launching App Trader as a company, you can assume the following:

-- a. App Trader will purchase apps for 10,000 times the price of the app. For apps that are priced from free up to $1.00, the purchase price is $10,000.
    
-- - For example, an app that costs $2.00 will be purchased for $20,000.
    
-- - The cost of an app is not affected by how many app stores it is on. A $1.00 app on the Apple app store will cost the same as a $1.00 app on both stores. 
    
-- - If an app is on both stores, it's purchase price will be calculated based off of the highest app price between the two stores. 

-- b. Apps earn $5000 per month, per app store it is on, from in-app advertising and in-app purchases, regardless of the price of the app.
    
-- - An app that costs $200,000 will make the same per month as an app that costs $1.00. 

-- - An app that is on both app stores will make $10,000 per month. 

-- c. App Trader will spend an average of $1000 per month to market an app regardless of the price of the app. If App Trader owns rights to the app in both stores, it can market the app for both stores for a single cost of $1000 per month.
    
-- - An app that costs $200,000 and an app that costs $1.00 will both cost $1000 a month for marketing, regardless of the number of stores it is in.

-- d. For every half point that an app gains in rating, its projected lifespan increases by one year. In other words, an app with a rating of 0 can be expected to be in use for 1 year, an app with a rating of 1.0 can be expected to last 3 years, and an app with a rating of 4.0 can be expected to last 9 years.
    
-- - App store ratings should be calculated by taking the average of the scores from both app stores and rounding to the nearest 0.5.

-- e. App Trader would prefer to work with apps that are available in both the App Store and the Play Store since they can market both for the same $1000 per month.


-- working backwards, eliminate any games that are not in both stores
-- build a table that has 'name', 'rating_count', 'rating' to add a column called 'longevity' using the formula above to calculate outcomes
	-- when sorting by 'rating_count', remember to use cast(rating_count as integer)
-- start breaking down a presentation format using my Canva Pro account, incorporate at least one fact outside the given data to show thorough research skills


-- select name, install_count, cast(price as money)
-- from play_store_apps
-- order by install_count desc


select distinct 
	name, 
	apple.rating as apple_rating, android.rating as android_rating, 
	cast(apple.price as money) as apple_price, cast(android.price as money) as android_price,
	round(round((android.rating + apple.rating), 0) / 2, 1) as avg_rating,
	cast(apple.review_count as integer) as apple_review_count
from play_store_apps as android
join app_store_apps as apple
using(name)
where apple.rating >= 4.5
	and apple.price < 1
order by avg_rating desc, apple_review_count desc



-- BUILD A SUBQUERY TO ADD BOTH RATINGS AND AVG THEM BEFORE DISPLAYING THEM AS AVG_RATING, ROUND TO THE NEAREST 0.5, THEN BUILD A APP_LIFESPAN COLUMN WHERE 

-- select distinct
-- 	name,
-- 	round(round((android.rating + apple.rating), 0) / 2, 1) as avg_rating,
-- 	case when avg_rating = 5.0 then '11 years'
-- 		 when avg_rating = 4.5 then '10 years'
-- 		 else null end as app_lifespan
-- from play_store_apps as android
-- join app_store_apps as apple
-- using(name)





-- INITIAL PURCHASE PRICE -> CREATE PURCHASE PRICE COLUMN?
-- $10K/MONTH (BECAUSE BOTH STORES ONLY) - $1K/MONTH (BOTH STORES, FOR MKTG) = 'PROFITABILITY' COLUMN?
-- RATING -> FILTER MIN RATING? FILTER MIN REVIEW_COUNT?
-- ONLY EIGHT 5-STAR RATINGS ON APPLE...

Select distinct google_name,
	google_price,
	google_rating, apple_name,
	apple_price, apple_rating,
	google_cost, apple_cost,
	apple_review,
	google_install,
	avg_rating,
	marketing_cost,
	(Case When apple_cost > google_cost
	Then apple_cost
	When apple_cost < google_cost
	Then google_cost
	When apple_cost = google_cost
	Then apple_cost End)As highest_cost
From(Select google.name As google_name,google.price As google_price,google.rating As google_rating,apple.name As apple_name,apple.price As apple_price,apple.rating As apple_rating,
	Cast(apple.review_count As INT) As apple_review,
	Cast(Left(Replace(google.install_count,',',''), Length(Replace(google.install_count,',','')) - 1) As INT) as google_install,
	Round(Round((google.rating + apple.rating),0)/2,1) As avg_rating,
	(((Round(Round((google.rating + apple.rating),0)/2,1))*24)+12)*1000 As marketing_cost,
	Case When apple.price <= 1
	Then 10000
	When (apple.price  > 1)
	Then (apple.price * 10000) End As apple_cost,
	Case When Cast(replace(google.price,'$','') As numeric) <= 1
	Then 10000
	When Cast(replace(google.price,'$','') As numeric) > 1
	Then Cast(replace(google.price,'$','') As numeric)* 10000 End As google_cost
From play_store_apps As google
Inner Join app_store_apps AS apple
On google.name = apple.name
-- Where apple.price < '1.00'
-- 	and google.price < '1.00'
order by apple.rating desc,google.rating desc)
Order By avg_rating DESC, apple_review DESC, google_install DESC;





-- #### 3. Deliverables

-- a. Develop some general recommendations as to the price range, genre, content rating, or anything else for apps that the company should target.

-- b. Develop a Top 10 List of the apps that App Trader should buy.

-- c. Submit a report based on your findings. All analysis work must be done using PostgreSQL, however you may export query results to create charts in Excel for your report. 

-- updated 2/18/2023