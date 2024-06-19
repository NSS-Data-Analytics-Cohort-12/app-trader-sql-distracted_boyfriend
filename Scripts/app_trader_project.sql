-- Select app_store_apps.name As app_name,
-- 	app_store_apps.rating As app_store_rating,
-- 	play_store_apps.rating As play_store_rating
-- From app_store_apps
-- Inner Join play_store_apps
-- On app_store_apps.name = play_store_apps.name
-- 	Where app_store_apps.price = 0
-- 		And play_store_apps.price = '0'
-- Order By app_name;

--474 free apps on both the play store and app store

-- Select app_store_apps.name As app_name,
-- 	app_store_apps.rating As app_store_rating,
-- 	play_store_apps.rating As play_store_rating,
-- 	Round((app_store_apps.rating + play_store_apps.rating)/2,2) As avg_rating
-- From app_store_apps
-- Inner Join play_store_apps
-- On app_store_apps.name = play_store_apps.name
-- 	Where app_store_apps.price = 0
-- 		And play_store_apps.price = '0'
-- 		And app_store_apps.rating >= 4
-- 		And play_store_apps.rating >= 4
-- Order By avg_rating DESC;

-- 345 Free Apps that have star ratings of 4 or more in both stores.

-- Select app_store_apps.name As app_name,
-- 	app_store_apps.rating As app_store_rating,
-- 	play_store_apps.rating As play_store_rating,
-- 	app_store_apps.price As app_store_price,
-- 	play_store_apps.price As play_store_price
-- From app_store_apps
-- Inner Join play_store_apps
-- On app_store_apps.name = play_store_apps.name
-- 	Where app_store_apps.rating = 5
-- 		Or play_store_apps.rating = 5
-- Order By app_name;

-- 10 Apps have a 5 star rating in atleast the app store or play store (but really just the app store)

--  Select app_store_apps.name As app_name,
-- 	app_store_apps.rating As app_store_rating,
-- 	play_store_apps.rating As play_store_rating,
-- 	Round(Round((play_store_apps.rating + app_store_apps.rating),0)/2,1) As avg_rating,
-- 	app_store_apps.price As app_store_price,
-- 	play_store_apps.price As play_store_price
-- From app_store_apps
-- Inner Join play_store_apps
-- On app_store_apps.name = play_store_apps.name
-- Where Round(Round((play_store_apps.rating + app_store_apps.rating),0)/2,1) = 5
-- Order By avg_rating DESC;

-- Same 10 apps have an average rating of 5.0 stars.

-- Select app_store_apps.name As app_name,
-- 	app_store_apps.rating As app_store_rating,
-- 	play_store_apps.rating As play_store_rating,
-- 	Round(Round((play_store_apps.rating + app_store_apps.rating),0)/2,1) As avg_rating
-- From app_store_apps
-- Inner Join play_store_apps
-- On app_store_apps.name = play_store_apps.name
-- Order By avg_rating;

-- Average rating for all apps found in both apps store

-- Select avg_rating,
-- 	Count(avg_rating) As avg_rating_count
-- From (
-- 	Select app_store_apps.name As app_name,
-- 		app_store_apps.rating As app_store_rating,
-- 		play_store_apps.rating As play_store_rating,
-- 		Round(Round((play_store_apps.rating + app_store_apps.rating),0)/2,1) As avg_rating
-- 	From app_store_apps
-- 	Inner Join play_store_apps
-- 	On app_store_apps.name = play_store_apps.name
-- 	Order By avg_rating DESC)
-- Group By avg_rating
-- Order by avg_rating DESC;

-- Count of average ratings from 2.5 to 5 stars for apps on both stores.

-- Select primary_genre,
-- 	Count(name) As num_of_apps
-- From app_store_apps
-- Group By primary_genre
-- Order By num_of_apps DESC;

-- Number of apps per genre in Apple Store

--  Select category,
-- 	Count(name) As num_of_apps
-- From play_store_apps
-- Group By category
-- Order By num_of_apps DESC;

-- Number of apps per category in Play Store (family = game)
	 
-- Select app_store_apps.name As app_name,
-- 	app_store_apps.price As app_price,
-- 	app_store_apps.rating As app_rating
-- From app_store_apps
-- Where app_store_apps.primary_genre ='Medical'
-- Order By app_store_apps.price, app_store_apps.rating DESC;

Select content_rating,
	Count(name) As num_of_apps
From app_store_apps
Where primary_genre = 'Games'
Group By content_rating
Order By num_of_apps DESC;
