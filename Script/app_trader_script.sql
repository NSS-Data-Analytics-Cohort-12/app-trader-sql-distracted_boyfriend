Select google.name,google.price,google.rating
From play_store_apps As google
Inner Join app_store_apps AS apple
On google.name = apple.name
Order By rating DESC;


