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

-- Select content_rating,
-- 	Count(name) As num_of_apps
-- From app_store_apps
-- Where primary_genre = 'Games'
-- Group By content_rating
-- Order By num_of_apps DESC;

-- 2079 apps, on Apple Store, that are games rated 4+ (or for everyone)

-- Select content_rating,
-- 	Count(name) As num_of_apps
-- From play_store_apps
-- Where category = 'GAME' Or category = 'FAMILY'
-- Group By content_rating
-- Order By num_of_apps DESC;

-- 2137 apps, specifically on play store, that are games rated fro everyone

Select Distinct app_store_apps.name As app_name,
	app_store_apps.primary_genre As genre,
	app_store_apps.rating As app_store_rating,
	play_store_apps.rating As play_store_rating,
	Round(Round((play_store_apps.rating + app_store_apps.rating),0)/2,1) As avg_rating
From app_store_apps
Inner Join play_store_apps
On app_store_apps.name = play_store_apps.name
Where app_store_apps.price = 0
	And play_store_apps.price = '0'
	And Round(Round((play_store_apps.rating + app_store_apps.rating),0)/2,1) = 5	
Order By avg_rating DESC;

-- Top 6 apps that are free and rated an average of 5.0 stars.

Select Distinct app_store_apps.name As name,
	Cast(app_store_apps.review_count As INT) As apple_reviews,
	Cast(Left(Replace(play_store_apps.install_count,',',''), Length(Replace(play_store_apps.install_count,',','')) - 1) As INT) as google_installs
From app_store_apps
Inner Join play_store_apps
On app_store_apps.name = play_store_apps.name
Where app_store_apps.price = 0
	And play_store_apps.price = '0'
Order By apple_reviews DESC, google_installs DESC;

-- Select Left(Replace(play_store_apps.install_count,',',''), Length(Replace(play_store_apps.install_count,',','')) - 1) As google_installs
-- From play_store_apps;

Select Distinct app_store_apps.name As app_name,
	app_store_apps.primary_genre As genre,
	app_store_apps.rating As app_store_rating,
	play_store_apps.rating As play_store_rating,
	Round(Round((play_store_apps.rating + app_store_apps.rating),0)/2,1) As avg_rating,
	Cast(app_store_apps.review_count As INT) As apple_reviews,
	Cast(Left(Replace(play_store_apps.install_count,',',''), Length(Replace(play_store_apps.install_count,',','')) - 1) As INT) as google_installs,
	app_store_apps.price As apple_price,
	play_store_apps.price As google_price
From app_store_apps
Inner Join play_store_apps
On app_store_apps.name = play_store_apps.name
Where Round(Round((play_store_apps.rating + app_store_apps.rating),0)/2,1) >= 4.5
Order By avg_rating DESC, google_installs DESC, apple_reviews DESC
Limit 11;

-- Select Distinct app_store_apps.name As app_name,
-- 	app_store_apps.primary_genre As genre,
-- 	app_store_apps.rating As app_store_rating,
-- 	play_store_apps.rating As play_store_rating,
-- 	Round(Round((play_store_apps.rating + app_store_apps.rating),0)/2,1) As avg_rating,
-- 	app_store_apps.price As apple_price,
-- 	play_store_apps.price As google_price
-- From app_store_apps
-- Inner Join play_store_apps
-- On app_store_apps.name = play_store_apps.name
-- Where Round(Round((play_store_apps.rating + app_store_apps.rating),0)/2,1) = 5	
-- Order By avg_rating DESC;

-- Select Distinct(google_name), 
-- 	google_price, 
-- 	google_rating, apple_name, 
-- 	apple_price, apple_rating, 
-- 	google_cost, apple_cost, 
-- 	apple_review,
-- 	google_install,
-- 	avg_rating,
-- 	marketing_cost,
-- 	revenue,
-- 	profit,
-- 	(Case When apple_cost > google_cost
-- 	Then apple_cost
-- 	When apple_cost < google_cost
-- 	Then google_cost
-- 	When apple_cost = google_cost
-- 	Then apple_cost End)As highest_cost
-- From(Select google.name As google_name,google.price As google_price,google.rating As google_rating,apple.name As apple_name,apple.price As apple_price,apple.rating As apple_rating,
-- 	Cast(apple.review_count As INT) As apple_review,
-- 	Cast(Left(Replace(google.install_count,',',''), Length(Replace(google.install_count,',','')) - 1) As INT) as google_install,
-- 	Round(Round((google.rating + apple.rating),0)/2,1) As avg_rating,
-- 	(((Round(Round((google.rating + apple.rating),0)/2,1))*24)+12)*1000 As marketing_cost,
-- 	(((Round(Round((google.rating + apple.rating),0)/2,1))*24)+12)*10000 As revenue,
-- 	((((Round(Round((google.rating + apple.rating),0)/2,1))*24)+12)*10000)-(((((Round(Round((google.rating + apple.rating),0)/2,1))*24)+12)*1000)+(Case When apple.price <= 1
-- 	Then 10000
-- 	When (apple.price  > 1)
-- 	Then (apple.price * 10000) End As apple_cost,
-- 	Case When Cast(replace(google.price,'$','') As numeric) <= 1
-- 	Then 10000
-- 	When Cast(replace(google.price,'$','') As numeric) > 1
-- 	Then Cast(replace(google.price,'$','') As numeric)* 10000 End)) As profit,
-- 	Case When apple.price <= 1
-- 	Then 10000
-- 	When (apple.price  > 1)
-- 	Then (apple.price * 10000) End As apple_cost,
-- 	Case When Cast(replace(google.price,'$','') As numeric) <= 1
-- 	Then 10000
-- 	When Cast(replace(google.price,'$','') As numeric) > 1
-- 	Then Cast(replace(google.price,'$','') As numeric)* 10000 End As google_cost
-- From play_store_apps As google
-- Inner Join app_store_apps AS apple
-- On google.name = apple.name
-- -- Where apple.price < '1.00'
-- -- 	and google.price < '1.00'
-- order by apple.rating desc,google.rating desc)
-- Order By avg_rating DESC, apple_review DESC, google_install DESC;

--------------------------------------------------------------------------------------------------------------------------------------

With initial As Select Distinct(a.name) As name,
	Greatest(a.price, Cast(Trim(Replace(g.price, '$','')) As numeric)) As price,
	Round(Round((g.rating + a.rating),0)/2,1) As avg_rating
From app_store_apps As a
Inner Join play_store_apps As g
On a.name = g.name
Order By avg_rating DESC;

Select name,
	
	