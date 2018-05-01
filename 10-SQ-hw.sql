use sakila
## Homework Assignment

# 1a. You need a list of all the actors who have Display the first and last names of all actors from the table `actor`. 
select first_name, last_name from actor

# 1b. Display the first and last name of each actor in a single column in upper case letters. Name the column `Actor Name`. 
select UPPER(CONCAT(first_name ,' ',last_name)) AS 'Actor Name' from actor

# 2a. You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." What is one query would you use to obtain this information?
  	
    select * from actor where first_name='Joe'
    
# 2b. Find all actors whose last name contain the letters `GEN`:

 select * from actor where upper(last_name) LIKE '%GEN%'
  	
# 2c. Find all actors whose last names contain the letters `LI`. This time, order the rows by last name and first name, in that order:

select * from actor where upper(last_name) LIKE '%LI%' ORDER BY LAST_NAME,FIRST_NAME

# 2d. Using `IN`, display the `country_id` and `country` columns of the following countries: Afghanistan, Bangladesh, and China:
SELECT * FROM  country WHERE  country IN ('Afghanistan', 'Bangladesh',  'China')

# 3a. Add a `middle_name` column to the table `actor`. Position it between `first_name` and `last_name`. Hint: you will need to specify the data type.

ALTER TABLE actor ADD COLUMN middle_name VARCHAR(15) AFTER first_name

SELECT * FROM actor
  	
#3b. You realize that some of these actors have tremendously long last names. Change the data type of the `middle_name` column to `blobs`.

ALTER TABLE `sakila`.`actor` 
CHANGE COLUMN `middle_name` `middle_name` BLOB NULL DEFAULT NULL ;

# 3c. Now delete the `middle_name` column.
ALTER TABLE `sakila`.`actor` 
DROP COLUMN `middle_name`;


# 4a. List the last names of actors, as well as how many actors have that last name.

select last_name ,count(last_name) "Count" from actor group by last_name
  	
# 4b. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
select last_name ,count(last_name) "Count" from actor group by last_name having count(last_name) >=2
  	
# 4c. Oh, no! The actor `HARPO WILLIAMS` was accidentally entered in the `actor` table as `GROUCHO WILLIAMS`, the name of Harpo's second cousin's husband's yoga teacher. Write a query to fix the record.
 Update actor set first_name='HARPO'
 where last_name='WILLIAMS' and first_name ='GROUCHO';
 
# 4d. Perhaps we were too hasty in changing `GROUCHO` to `HARPO`. 
 #It turns out that `GROUCHO` was the correct name after all! In a single query, 
 #if the first name of the actor is currently `HARPO`, change it to `GROUCHO`. 
 #Otherwise, change the first name to `MUCHO GROUCHO`, as that is exactly what the actor will be with the grievous error. 
 #BE CAREFUL NOT TO CHANGE THE FIRST NAME OF EVERY ACTOR TO `MUCHO GROUCHO`, HOWEVER! (Hint: update the record using a unique identifier.)

 Update actor set first_name='MUCHO GROUCHO'
 where actor_id = (select actor_id where 
 last_name='WILLIAMS' and first_name ='HARPO');
 

# 5a. You cannot locate the schema of the `address` table. Which query would you use to re-create it?

desc address

# 6a. Use `JOIN` to display the first and last names, as well as the address, of each staff member. Use the tables `staff` and `address`:
select first_name,last_name,b.* from staff a,address b
where a.address_id = b.address_id




# 6b. Use `JOIN` to display the total amount rung up by each staff member in August of 2005. Use tables `staff` and `payment`. 

select concat(first_name,' ',last_name ) staff_name  ,sum(amount) tot_amount  from payment a,staff b  where DATE_FORMAT(payment_date,'%m%Y')='082005'
and a.staff_id=b.staff_id
group by first_name,last_name
  	
# 6c. List each film and the number of actors who are listed for that film. Use tables `film_actor` and `film`. Use inner join.

select title ,count(actor_id) "Number of actors" from film_actor a , film b where a.film_id=b.film_id
group by title
  	
#* 6d. How many copies of the film `Hunchback Impossible` exist in the inventory system?

select count(*) "COUNT OF Hunchback Impossible in Inventory" from  inventory a, film b where a.film_id(+)=b.film_id
and b.title (+)='Hunchback Impossible'


# 6e. Using the tables `payment` and `customer` and the `JOIN` command, list the total paid by each customer. List the customers alphabetically by last name:

  ```
  #	![Total amount paid](Images/total_payment.png)
  
  ``
SELECT 
    first_name, last_name, SUM(amount) 'Total Amount Paid'
FROM
    payment a,
    customer b
WHERE
    a.customer_id = b.customer_id
GROUP BY first_name , last_name
ORDER BY last_name
  
  

* 7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, 
films starting with the letters `K` and `Q` have also soared in popularity. Use subqueries to display the titles of movies starting with the letters `K` and `Q` whose language is English. 

select  title from film where title like 'K%' or title like 'Q%'
and language_id  =(select language_id from language where  name = 'English')


* 7b. Use subqueries to display all actors who appear in the film `Alone Trip`.

select first_name from film_actor a, actor b where film_id = (select film_id from film where title='Alone Trip')
and a.actor_id=b.actor_id
   
* 7c. You want to run an email marketing campaign in Canada, for which you will need the names and
 email addresses of all Canadian customers. Use joins to retrieve this information.
 
 select first_name, last_name,email  from  customer d,address c ,country a, city b 
 where country='Canada' and a.country_id=b.country_id and b.city_id=c.city_id 
 and d.address_id =c.address_id
 

* 7d. Sales have been lagging among young families, and
 you wish to target all family movies for a promotion. Identify all movies categorized as famiy films.
 
 select title from  category a,film_category b ,film c where a.name='Family' and a.category_id =b.category_id and b.film_id=c.film_id
 
 

* 7e. Display the most frequently rented movies in descending order.

select title,count(distinct rental_id) from rental a,inventory b ,film c where a.inventory_id=b.inventory_id and b.film_id=c.film_id
group by title order by 2 desc 
  	
* 7f. Write a query to display how much business, in dollars, each store brought in.

* 7g. Write a query to display for each store its store ID, city, and country.
  	
* 7h. List the top five genres in gross revenue in descending order. (**Hint**: you may need to use the following tables: category, film_category, inventory, payment, and rental.)
  	
* 8a. In your new role as an executive, you would like to have an easy way of viewing the Top five genres by gross revenue. Use the solution from the problem above to create a view. If you haven't solved 7h, you can substitute another query to create a view.
  	
* 8b. How would you display the view that you created in 8a?

* 8c. You find that you no longer need the view `top_five_genres`. Write a query to delete it.

### Appendix: List of Tables in the Sakila DB

* A schema is also available as `sakila_schema.svg`. Open it with a browser to view.

```sql
	'actor'
	'actor_info'
	'address'
	'category'
	'city'
	'country'
	'customer'
	'customer_list'
	'film'
	'film_actor'
	'film_category'
	'film_list'
	'film_text'
	'inventory'
	'language'
	'nicer_but_slower_film_list'
	'payment'
	'rental'
	'sales_by_film_category'
	'sales_by_store'
	'staff'
	'staff_list'
	'store'
```
