-- Your team has been hired by a new company called App Trader to help them explore and gain insights from apps that are made available through the Apple App Store and Android Play Store. App Trader is a broker that purchases the rights to apps from developers in order to market the apps and offer in-app purchase. 

-- Unfortunately, the data for Apple App Store apps and Android Play Store Apps is located in separate tables with no referential integrity.

WITH apps AS (
		(SELECT 
			name,
			'Google Play' AS store,
		 	CAST(TRIM(REPLACE(price, '$', '')) AS numeric(5,2)) AS cleaned_price,
			rating,
		 	review_count::int,
		 	RANK() OVER(PARTITION BY name ORDER BY review_count::int DESC)
		FROM play_store_apps)
	UNION
		(SELECT 
		 	name,
			'Apple Store' AS store,
		 	price AS cleaned_price,
			rating,
			review_count::int,
			RANK() OVER(PARTITION BY name ORDER BY review_count::int DESC)
		FROM app_store_apps)
),
lifespan_calculations AS (
	SELECT
		name,
		COUNT(store) AS num_stores,
		AVG(rating) AS rating,
		ROUND(2 * AVG(rating)) / 2 AS rating_rounded,  --Trick to round to nearest half star
		1 + ROUND(2 * AVG(rating)) AS lifespan
	FROM apps
	WHERE rank = 1
	GROUP BY name),
purchase_prices AS (
	SELECT
		name,
		MAX(cleaned_price) AS cleaned_price,
		CASE
			WHEN MAX(cleaned_price) < 1 THEN 10000
			ELSE 10000 * MAX(cleaned_price)
		END AS purchase_price
	FROM apps
	GROUP BY name
),
revenue_cost_calculations AS (
	SELECT 
		name,
		num_stores,
		rating_rounded,
		lifespan,
		num_stores * 5000 * 12 * lifespan AS total_revenue,
		1000 * 12 * lifespan AS total_marketing_cost,
		purchase_price
	FROM lifespan_calculations
	INNER JOIN purchase_prices
	USING(name))
SELECT
	name,
	total_revenue - total_marketing_cost - purchase_price AS expected_profit
FROM revenue_cost_calculations
WHERE total_revenue - total_marketing_cost - purchase_price IS NOT NULL
ORDER BY expected_profit DESC;
