
-- with app_store as 
-- (select name, cast(replace(price, '$', '') as decimal (10,2)) as new_price 
-- from app_store_apps),
-- play_store as 
-- (select name, cast(replace(price, '$', '') as decimal (10,2)) as new_price 
-- from play_store_apps),
-- combined_apps as
-- (select (app_store,play_store) as app_name,
-- 	greatest(a.new_price) , (p.new_price) as high_price
-- from app_store_apps as a
-- full outer join
-- play_store_apps as p on a.name = p.name)
-- select name, high_price,
-- case when high_price <=1 then 10000
-- else high_price * 10000
-- end as purchase_price
-- from combined_apps

select distinct(genres), price from play_store_apps
where genres like '%;Education%'
