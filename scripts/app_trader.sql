-- select distinct app_store_apps.name as app_name,
-- app_store_apps.primary_genre as genre,
-- app_store_apps.rating as app_store_rating,
-- play_store_apps.rating as play_store_rating,
-- round(round((play_store_apps.rating + app_store_ratings.rating),0)/2,1) as avg_rating
-- 	from app_store_apps
-- 	inner join play_store_apps
-- 	on app_store_apps.name = play_store_apps.name
-- 	where app_store_apps.price = 0
-- 	and play_store_apps.price = '0'
-- 	and round(round((play_store_apps.rating + app_store_apps.rating),0)/2,1) = 5
-- 	order by avg_rating desc;

-- SELECT DISTINCT app_store_apps.name AS app_name,
	
-- 	select round(play_store_apps.rating + app_store_apps.rating),0,1) AS avg_rating

-- FROM app_store_apps

-- select distinct(a.name) as app_name, a.primary_genre as genre, a.rating as a_rating, p.rating as p_rating, round(p.rating + a.rating) as avg_rating, p.price
-- from app_store_apps as a
-- inner join play_store_apps as p
-- using (name)
-- where a.price = 0
-- and p.price = '0'
-- and (p.rating + a.rating) >= 10
-- order by avg_rating desc;

with astore as 
(select name, price as price_in_money, rating from app_store_apps),
pstore as (select name, cast(replace(price, '$', '') as decimal(10,2)) as price_in_money, rating from play_store_apps,
bothapps as 
select (coalesce(a.name, p.name) as appname,
greatest(coalesce(a.price, 0), coalesce(p.price, 0)) as highprice
coalesce(a.rating, 0) AS app_store_rating,
coalesce(p.rating, 0) as play_store_rating.
	from app_store_apps as a 
full outer join play_store_apps as p
using(name))