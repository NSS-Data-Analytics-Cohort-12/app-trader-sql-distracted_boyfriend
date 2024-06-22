-- Select google_name,
-- 	google_price,
-- 	google_rating, 
-- 	apple_name, apple_price,
-- 	apple_rating, 
-- 	google_cost,
-- 	apple_cost,
-- 	(Case When apple_cost > google_cost
-- 	Then apple_cost
-- 	When apple_cost < google_cost
-- 	Then google_cost
-- 	When apple_cost = google_cost
-- 	Then apple_cost End)As highest_cost
-- From(Select google.name As google_name,google.price As google_price,google.rating As google_rating,apple.name As apple_name,apple.price As apple_price,apple.rating As apple_rating,
-- 	apple.review_count
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
-- order by apple.rating desc,google.rating desc);
-- 
Select Distinct google_name,
	google_price,
	google_rating, apple_name,
	apple_price, apple_rating,
	google_cost, apple_cost,
	apple_review,
	google_install,
	avg_rating,
	marketing_cost,
	revenue,
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
	(((Round(Round((google.rating + apple.rating),0)/2,1))*24)+12)*10000 AS revenue,
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

-- select
-- 			distinct a.name,
-- 			-- p.name,
-- 			greatest(
-- 				a.price, 
-- 				CAST( TRIM( REPLACE(p.price, '$', '') ) AS numeric )
-- 			) as cleanedPrice
-- --			1 + ( 2 *(round(a.rating + p.rating) / 2 ) ) as lifespan,
-- --			1000 * 12 * ( 1 + ( 2 *( round(a.rating + p.rating) / 2 ) ) ) as marketingPrice
-- 		from app_store_apps a
-- 		inner join play_store_apps p
-- 		on lower(a.name) = lower(p.name)












