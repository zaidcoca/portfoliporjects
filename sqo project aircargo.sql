Create database Aircargo
use aircargo;
drop database aircarge
select * from customer; 
select * from passengers_on_flights


select * from customer as c
inner join passengers_on_flights as pof
on c.customer_id=pof.customer_id
inner join routes as r
on pof.route_id=r.route_id
inner join ticket_details as td
on r.aircraft_id=td.aircraft_id

alter table customer add constraint primary key (customer_id);

alter table ticket_details add constraint foreign_key 
foreign key (customer_id) references customer (customer_id);

alter table routes add constraint primary key (route_id);
alter table passengers_on_flights add constraint foreign_keyy 
foreign key (route_id) references routes (route_id);


alter table routes drop primary key;
alter table passengers_on_flights drop foreign key foreign_key ;


-- (3) Write a query to display all the passengers (customers) who have travelled in routes 01 to 25. Take data  from the passengers_on_flights table.

select * from customer as c
inner join passengers_on_flights as pof
on c.customer_id=pof.customer_id
where route_id between 01 and 25
order by c.customer_id

-- (4) Write a query to identify the number of passengers and total revenue in business class from the ticket_details table.

select  count(customer_id), sum(price_per_ticket) from ticket_details
where class_id= "Bussiness"

-- (5) Write a query to display the full name of the customer by extracting the first name and last name from the customer table.

select first_name, last_name, concat(first_name, " ", last_name) as `full name` from customer 

-- (6) Write a query to extract the customers who have registered and booked a ticket. Use data from the customer and ticket_details tables.

select * from customer c
inner join ticket_details td
on c.customer_id=td.customer_id

-- (7) Write a query to identify the customer’s first name and last name based on their customer ID and brand (Emirates) from the ticket_details table.

select first_name, last_name from customer c
inner join ticket_details td
on c.customer_id=td.customer_id
where brand= "emirates"
order by first_name 

-- (8) Write a query to identify the customers who have travelled by Economy Plus class using Group By and Having clause on the passengers_on_flights table

select customer_id, class_id from passengers_on_flights
group by class_id, customer_id
having class_id= "economy plus"
order by customer_id

-- (9) Write a query to identify whether the revenue has crossed 10000 using the IF clause on the ticket_details table.
 
 select if(sum(price_per_ticket),"Passed", "Didn't pass") as `Revenue target` from ticket_details


-- (10) Write a query to create and grant access to a new user to perform operations on a database.


-- (11) Write a query to find the maximum ticket price for each class using window functions on the ticket_details table.

select distinct class_id, max(price_per_ticket) from ticket_details
group by class_id
order by max(price_per_ticket) desc

-- (12) Write a query to extract the passengers whose route ID is 4 by improving the speed and performance of the passengers_on_flights table.

select customer_id from passengers_on_flights
where route_id=4


-- (13)  For the route ID 4, write a query to view the execution plan of the passengers_on_flights table.


-- (14) Write a query to calculate the total price of all tickets booked by a customer across different aircraft IDs using rollup function.

select aircraft_id, sum(price_per_ticket) from ticket_details
group by aircraft_id with rollup;

-- (15) Write a query to create a view with only business class customers along with the brand of airlines.

create view class_business_brand
as
select customer_id, brand from ticket_details
where class_id="bussiness";

select * from class_business_brand

-- (16) Write a query to create a stored procedure to get the details of all passengers flying between a range of routes defined in run time.
--  Also, return an error message if the table doesn't exist. 

delimiter // 
create procedure  route(cid int)
begin 
select * from passengers_on_flights
where route_id=cid; 
end//
delimiter ; 

call route (4)

-- (17) Write a query to create a stored procedure that extracts all the details from the routes table where the travelled distance is more than 2000 miles.

delimiter // 
create procedure distance()
begin
select * from routes
where distance_miles>1000;

end //

delimiter ;

call distance

-- (18) Write a query to create a stored procedure that groups the distance travelled by each flight into three categories. The categories are,
-- short distance travel (SDT) for >=0 AND <= 2000 miles, intermediate distance travel (IDT) for >2000 AND <=6500, and long-distance travel
--  (LDT) for >6500.

use aircargo
drop procedure distance_traveled

delimiter // 
create procedure distance_traveled()
begin
select flight_num, distance_miles, if(distance_miles<2000,"SDT",if(distance_miles<=6500,"IDT",if(distance_miles>6500,"LDT", "Not result"))) as FD_Categories from routes
order by distance_miles asc ;
end // 

delimiter ; 

call distance_traveled

-- (19) Write a query to extract ticket purchase date, customer ID, class ID and specify if the complimentary services are provided for the specific
--  class using a stored function in stored procedure on the ticket_details table.

drop procedure complientaryservice

Delimiter // 
Create procedure complientaryservice()
begin
select p_date, customer_id, class_id, if(class_id="Bussiness" or class_id= "Economy Plus", "Yes", "No") 
as `Compliemntary servie` from ticket_details
order by customer_id  ;
End //
Delimiter ;

Call complientaryservice

-- (20) Write a query to extract the first record of the customer whose last name ends with Scott using a cursor from the customer table.

select * from customer 
where last_name like "%scott"






