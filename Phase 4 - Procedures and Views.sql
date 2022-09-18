-- CS4400: Introduction to Database Systems (Fall 2021)
-- Phase III: Stored Procedures & Views [v0] Tuesday, November 9, 2021 @ 12:00am EDT
-- Team __
-- Team Member Name (GT username)
-- Team Member Name (GT username)
-- Team Member Name (GT username)
-- Team Member Name (GT username)
-- Directions:
-- Please follow all instructions for Phase III as listed on Canvas.
-- Fill in the team number and names and GT usernames for all members above.


-- ID: 1a
-- Name: register_customer
drop procedure if exists register_customer;
delimiter //
create procedure register_customer (
    in i_email varchar(50),
    in i_first_name varchar(100),
    in i_last_name varchar(100),
    in i_password varchar(50),
    in i_phone_number char(12),
    in i_cc_number varchar(19),
    in i_cvv char(3),
    in i_exp_date date,
    in i_location varchar(50)
) 
sp_main: begin
-- TODO: Implement your solution here
if (select count(*) from (Accounts as acc),(Clients as c) where acc.Email=i_email AND c.Email=i_email) >= 1
then 
	if (select count(*) from Customer where Email=i_email) = 0
		then 
		INSERT INTO Customer (Email, CCNumber, Cvv, Exp_Date, Location) VALUES
		(i_email, i_cc_number, i_cvv, i_exp_date, i_location);
		leave sp_main; 
        end if;
end if;

if (select count(*) from Clients where (Email=i_email and Phone_Number=i_phone_number)) > 0
then leave sp_main; end if;

if (select count(*) from Customer where (CcNumber=i_cc_number) OR ((select count(*) from Clients where Phone_Number=i_phone_number)>0)) > 0
then leave sp_main; end if;

INSERT INTO Accounts (Email, First_Name, Last_Name, Pass) VALUES
(i_email, i_first_name, i_last_name, i_password);
INSERT INTO Clients (Email, Phone_Number) VALUES
(i_email, i_phone_number);
INSERT INTO Customer (Email, CCNumber, Cvv, Exp_Date, Location) VALUES
(i_email, i_cc_number, i_cvv, i_exp_date, i_location);
end //
delimiter ;


-- ID: 1b
-- Name: register_owner
drop procedure if exists register_owner;
delimiter //
create procedure register_owner (
    in i_email varchar(50),
    in i_first_name varchar(100),
    in i_last_name varchar(100),
    in i_password varchar(50),
    in i_phone_number char(12)
) 
sp_main: begin
-- TODO: Implement your solution here
if (select count(*) from (Accounts as acc),(Clients as c) where acc.Email=i_email AND c.Email=i_email) >= 1
then 
	if (select count(*) from Owners where Email=i_email) = 0
		then 
		INSERT INTO Owners (Email) VALUES
		(i_email);
		leave sp_main; 
	end if;
end if;

if (select count(*) from Clients where (Email=i_email and Phone_Number=i_phone_number)) > 0
then leave sp_main; end if;

if (select count(*) from Owners where (Email=(select Email from Clients where Phone_Number = i_phone_number))) > 0
then leave sp_main; end if;

INSERT INTO Accounts (Email, First_Name, Last_Name, Pass) VALUES
(i_email, i_first_name, i_last_name, i_password);
INSERT INTO Clients (Email, Phone_Number) VALUES
(i_email, i_phone_number);
INSERT INTO Owners (Email) VALUES
(i_email);
end //
delimiter ;


-- ID: 1c
-- Name: remove_owner
drop procedure if exists remove_owner;
delimiter //
create procedure remove_owner ( 
    in i_owner_email varchar(50)
)
sp_main: begin
-- TODO: Implement your solution here
drop procedure if exists remove_owner;
delimiter //
create procedure remove_owner ( 
    in i_owner_email varchar(50)
)
sp_main: begin
-- TODO: Implement your solution here
if (select count(*) from Property where (Owner_Email=i_owner_email)) > 0
then leave sp_main; end if;

DELETE FROM Owners WHERE Email=i_owner_email;
DELETE FROM Owners_Rate_Customers WHERE Owner_Email=i_owner_email;

if (select count(*) from Customer where (Email=i_owner_email)) = 0
then 
DELETE FROM Clients WHERE Email=i_owner_email;
DELETE FROM Accounts WHERE Email=i_owner_email;
end if;
end //
delimiter ;


-- ID: 2a
-- Name: schedule_flight
drop procedure if exists schedule_flight;
delimiter //
create procedure schedule_flight (
    in i_flight_num char(5),
    in i_airline_name varchar(50),
    in i_from_airport char(3),
    in i_to_airport char(3),
    in i_departure_time time,
    in i_arrival_time time,
    in i_flight_date date,
    in i_cost decimal(6, 2),
    in i_capacity int,
    in i_current_date date
)
sp_main: begin
-- TODO: Implement your solution here
if (SELECT count(*) FROM Flight AS f WHERE Flight_Num = i_flight_num and Airline_Name=i_airline_name GROUP BY f.Flight_Num,f.Airline_Name HAVING COUNT(*)) >= 1
then leave sp_main; end if;
if (i_from_airport = i_to_airport)
then leave sp_main; end if;
if (i_flight_date < i_current_date)
then leave sp_main; end if;
INSERT INTO Flight (Flight_Num, Airline_Name, From_Airport, To_Airport, 
Departure_Time, Arrival_Time, Flight_Date, Cost, Capacity) VALUES
(i_flight_num, i_airline_name, i_from_airport, i_to_airport, i_departure_time, i_arrival_time, i_flight_date, i_cost, i_capacity);
end //
delimiter ;


-- ID: 2b
-- Name: remove_flight
drop procedure if exists remove_flight;
delimiter //
create procedure remove_flight ( 
    in i_flight_num char(5),
    in i_airline_name varchar(50),
    in i_current_date date
) 
sp_main: begin
-- TODO: Implement your solution here
if (select Flight_Date from Flight where (Flight_Num=i_flight_num)) < i_current_date
then leave sp_main; end if;
DELETE FROM Book WHERE (Flight_Num=i_flight_num and Airline_Name=i_airline_name);
DELETE FROM Flight WHERE (Flight_Num=i_flight_num and Airline_Name=i_airline_name);

end //
delimiter ;


-- ID: 3a
-- Name: book_flight
drop procedure if exists book_flight;
delimiter //
create procedure book_flight (
    in i_customer_email varchar(50),
    in i_flight_num char(5),
    in i_airline_name varchar(50),
    in i_num_seats int,
    in i_current_date date
)
sp_main: begin
-- TODO: Implement your solution here
if ((select Capacity from Flight where i_flight_num = Flight_Num and i_airline_name = Airline_Name)<i_num_seats) then leave sp_main; end if; 
if(i_current_date> (select flight_date from flight where i_flight_num = flight_num and i_airline_name = Airline_Name)) then leave sp_main; end if; 
if ((i_customer_email,i_flight_num, i_airline_name) in (select Customer,Flight_Num,Airline_Name from book)) then leave sp_main; end if; 
insert into Book values(i_customer_email, i_flight_num, i_airline_name, i_num_seats, i_current_date);


if (((i_customer_email,i_flight_num, i_airline_name) in (select Customer,Flight_Num,Airline_Name from book)) and (select Was_Cancelled from book join flight on (book.Flight_Num= i_flight_num and book.Airline_Name= i_airline_name)) <> 1) then update book set Num_Seats= Num_Seats + i_num_seats 
where i_customer_email= Customer and i_flight_num=Flight_Num and i_airline_name=Airline_Name; end if;


end //
delimiter ;

-- ID: 3b
-- Name: cancel_flight_booking
drop procedure if exists cancel_flight_booking;
delimiter //
create procedure cancel_flight_booking ( 
    in i_customer_email varchar(50),
    in i_flight_num char(5),
    in i_airline_name varchar(50),
    in i_current_date date
)
sp_main: begin
-- TODO: Implement your solution here
if (SELECT flight_date FROM flight  where airline_name = i_airline_name and flight_num = i_flight_num) 

    <= i_current_date then leave sp_main; end if;  -- if the flight is before current date leave function  

-- checking if customer is booked for this flight

if (SELECT flight_num FROM book where flight_num = i_flight_num and customer = i_customer_email)

then 

UPDATE book set was_cancelled =  1  

where flight_num = i_flight_num;  

end if; 
end //
delimiter ;


-- ID: 3c
-- Name: view_flight
create or replace view view_flight (
    flight_id,
    flight_date,
    airline,
    destination,
    seat_cost,
    num_empty_seats,
    total_spent
) as
-- TODO: replace this select query with your solution
select t4.flight_num, flight_date, airline_name, to_airport, cost, 
if((capacity - seats_booked) is NULL, capacity, capacity - seats_booked) as num_empty_seats, ifnull(total_spent,0)
from flight as t4 left join

(select t2.flight_num, seats_booked, 
if((total_not_cancelled + total_cancelled) is NULL, total_not_cancelled,(total_not_cancelled + total_cancelled))
as total_spent
from 
(select flight.flight_num, seats_booked, (cost * seats_booked) as total_not_cancelled from
flight join
(select flight_num, sum(num_seats) as seats_booked from book where was_cancelled = 0 group by flight_num) as t1
on flight.flight_num = t1.flight_num) as t2

left join

(select flight.flight_num, seats_cancelled, (0.20 * cost * seats_cancelled) as total_cancelled from
flight join
(select flight_num, sum(num_seats) as seats_cancelled from book where was_cancelled = 1 group by flight_num) as t1
on flight.flight_num = t1.flight_num) as t3
on t2.flight_num = t3.flight_num) as t5

on t4.flight_num = t5.flight_num;

-- ID: 4a
-- Name: add_property
drop procedure if exists add_property;
delimiter //
create procedure add_property (
    in i_property_name varchar(50),
    in i_owner_email varchar(50),
    in i_description varchar(500),
    in i_capacity int,
    in i_cost decimal(6, 2),
    in i_street varchar(50),
    in i_city varchar(50),
    in i_state char(2),
    in i_zip char(5),
    in i_nearest_airport_id char(3),
    in i_dist_to_airport int
) 
sp_main: begin
-- TODO: Implement your solution here
if (select count(*) from (Property as p) where p.Street = i_street AND p.City = i_city AND p.State = i_state AND p.Zip = i_zip) > 0
    then leave sp_main; end if;
    if (SELECT count(*) FROM Property AS P WHERE P.Property_Name = i_property_name and P.Owner_Email = i_owner_email GROUP BY P.Property_Name, P.Owner_Email HAVING COUNT(*)) >= 1
	then leave sp_main; end if;
	if (select count(*) from Airport as A WHERE A.Airport_Id = i_nearest_airport_id) = 0
    then
		INSERT INTO Property
		VALUES (i_property_name,i_owner_email, i_description, i_capacity, i_cost, i_street, i_city, i_state, i_zip);
		leave sp_main;
	end if;
    if i_nearest_airport_id = NULL or i_dist_to_airport = NULL then
		INSERT INTO Property
		VALUES (i_property_name,i_owner_email, i_description, i_capacity, i_cost, i_street, i_city, i_state, i_zip);
    leave sp_main;
    end if;
    INSERT INTO Property
	VALUES (i_property_name,i_owner_email, i_description, i_capacity, i_cost, i_street, i_city, i_state, i_zip);
    INSERT INTO Is_Close_To VALUES (i_property_name, i_owner_email, i_nearest_airport_id, i_dist_to_airport);
end //
delimiter ;


-- ID: 4b
-- Name: remove_property
drop procedure if exists remove_property;
delimiter //
create procedure remove_property (
    in i_property_name varchar(50),
    in i_owner_email varchar(50),
    in i_current_date date
)
sp_main: begin
-- TODO: Implement your solution here
 if i_current_date between (select Start_Date from Reserve as r where r.Property_Name = i_property_name and r.Owner_Email = i_owner_email)
	and (select End_Date from Reserve as r where r.Property_Name = i_property_name and r.Owner_Email = i_owner_email)
   then leave sp_main; end if;
    
    DELETE FROM Property
	WHERE Property_Name = i_property_name and Owner_Email =  i_owner_email;
    
    DELETE FROM Reserve
	WHERE Property_Name = i_property_name and Owner_Email =  i_owner_email;
    
    DELETE FROM Review
	WHERE Property_Name = i_property_name and Owner_Email =  i_owner_email;
    
    DELETE FROM Amenity
	WHERE Property_Name = i_property_name and Property_Owner =  i_owner_email;
    
    DELETE FROM Is_Close_To
	WHERE ict.Property_Name = i_property_name and ict.Owner_Email =  i_owner_email;
end //
delimiter ;


-- ID: 5a
-- Name: reserve_property
drop procedure if exists reserve_property;
delimiter //
create procedure reserve_property (
    in i_property_name varchar(50),
    in i_owner_email varchar(50),
    in i_customer_email varchar(50),
    in i_start_date date,
    in i_end_date date,
    in i_num_guests int,
    in i_current_date date
)
sp_main: begin
-- TODO: Implement your solution here
if ((i_property_name,i_owner_email,i_customer_email) in (select Property_Name, Owner_Email, Customer from Reserve)) then leave sp_main; end if;
if (i_start_date<i_current_date) then leave sp_main; end if;
if ( select count(*) from Reserve where Customer = i_customer_email and (Start_Date<=i_start_date<=End_Date or Start_Date<=i_end_date<=End_date) >0) then leave sp_main; end if;
if( (select Capacity from Property where Property_Name=i_property_name) < i_num_guests + (select sum(num_guests) from Reserve where (Property_Name=i_property_name and (i_start_date<= Start_Date <=i_end_date or i_start_date<=End_Date<=i_end_date)))) then leave sp_main; end if;
insert into Reserve values (i_property_name, i_owner_email, i_customer_email, i_start_date, i_end_date, i_num_guests, FALSE);
end //
delimiter ;


-- ID: 5b
-- Name: cancel_property_reservation
drop procedure if exists cancel_property_reservation;
delimiter //
create procedure cancel_property_reservation (
    in i_property_name varchar(50),
    in i_owner_email varchar(50),
    in i_customer_email varchar(50),
    in i_current_date date
)
sp_main: begin
-- TODO: Implement your solution here
if (i_property_name, i_owner_email, i_customer_email) not in (Select Property_Name,Owner_Email, Customer from Reserve) then leave sp_main; end if;
if (i_current_date>(select Start_Date from Reserve where i_property_name=property_name and i_owner_email= owner_email and i_customer_email=Customer)) then leave sp_main; end if;

update Reserve set Was_cancelled = 1 where Property_Name=i_property_name and Owner_Email=i_owner_email and Customer= i_customer_email;
end //
delimiter ;


-- ID: 5c
-- Name: customer_review_property
drop procedure if exists customer_review_property;
delimiter //
create procedure customer_review_property (
    in i_property_name varchar(50),
    in i_owner_email varchar(50),
    in i_customer_email varchar(50),
    in i_content varchar(500),
    in i_score int,
    in i_current_date date
)
sp_main: begin
-- TODO: Implement your solution here
if (i_current_date<= (select Start_Date from Reserve where Property_Name=i_property_name and Owner_Email=i_owner_email and Customer=i_Customer_email)) then leave sp_main; end if;
if ((i_property_name,i_owner_email,i_customer_email) not in (select Property_Name,Owner_Email,Customer from Reserve)) then leave sp_main; end if;    
if ((i_property_name,i_owner_email,i_customer_email) in (select Property_Name,Owner_Email,Customer from Review)) then leave sp_main; end if;

insert into Review values (i_property_name, i_owner_email, i_customer_email, i_content, i_score);

end //
delimiter ;


-- ID: 5d
-- Name: view_properties
create or replace view view_properties (
    property_name, 
    average_rating_score, 
    description, 
    address, 
    capacity, 
    cost_per_night
) as
-- TODO: replace this select query with your solution

select property_name, avg_score, descr,
concat(Street,", ", City, ", ", State, ", ", Zip), capacity, cost from property as p left outer join
(select property_name as rp, avg(score) as avg_score from review group by rp) as scores
on p.property_name = scores.rp;

-- ID: 5e
-- Name: view_individual_property_reservations
drop procedure if exists view_individual_property_reservations;
delimiter //
create procedure view_individual_property_reservations (
    in i_property_name varchar(50),
    in i_owner_email varchar(50)
)
sp_main: begin
    drop table if exists view_individual_property_reservations;
    create table view_individual_property_reservations (
        property_name varchar(50),
        start_date date,
        end_date date,
        customer_email varchar(50),
        customer_phone_num char(12),
        total_booking_cost decimal(6,2),
        rating_score int,
        review varchar(500)
    ) as
    -- TODO: replace this select query with your solution
    #if ((i_property_name, i_owner_email) not in (select Property_Name,Owner_Email from Reserve)) then leave sp_main; end if;
    select 'col1', 'col2', 'col3', 'col4', 'col5', 'col6', 'col7', 'col8' from reserve;

end //
delimiter ;


-- ID: 6a
-- Name: customer_rates_owner
drop procedure if exists customer_rates_owner;
delimiter //
create procedure customer_rates_owner (
    in i_customer_email varchar(50),
    in i_owner_email varchar(50),
    in i_score int,
    in i_current_date date
)
sp_main: begin
-- TODO: Implement your solution here
if (select count(*) from Reserve as r 
where r.Owner_Email = i_owner_email and r.Customer = i_customer_email and r.Start_Date < i_current_date
and r.Was_Cancelled = 1) > 0
then leave sp_main; end if;
if (select count(*) from Reserve as r 
where r.Owner_Email = i_owner_email and r.Customer = i_customer_email and r.Start_Date > i_current_date) > 0
then leave sp_main; end if;
if (select count(*) from Customer as c where c.Email = i_customer_email) = 0
then leave sp_main; end if;
if (select count(*) from Owners as o where o.Email = i_owner_email) = 0
then leave sp_main; end if;
if (select count(*) from Customers_Rate_Owners as c where c.Owner_Email = i_owner_email and c.Customer = i_customer_email) > 0
then leave sp_main; end if;

INSERT INTO Customers_Rate_Owners VALUES (i_customer_email, i_owner_email, i_score);
end //
delimiter ;


-- ID: 6b
-- Name: owner_rates_customer
drop procedure if exists owner_rates_customer;
delimiter //
create procedure owner_rates_customer (
    in i_owner_email varchar(50),
    in i_customer_email varchar(50),
    in i_score int,
    in i_current_date date
)
sp_main: begin
-- TODO: Implement your solution here
if (select count(*) from Reserve as r 
where r.Owner_Email = i_owner_email and r.Customer = i_customer_email and r.Start_Date < i_current_date
and r.Was_Cancelled = 1) > 0
then leave sp_main; end if;
if (select count(*) from Reserve as r 
where r.Owner_Email = i_owner_email and r.Customer = i_customer_email and r.Start_Date > i_current_date) > 0
then leave sp_main; end if;
if (select count(*) from Customer as c where c.Email = i_customer_email) = 0
then leave sp_main; end if;
if (select count(*) from Owners as o where o.Email = i_owner_email) = 0
then leave sp_main; end if;
if (select count(*) from Owners_Rate_Customers as o where o.Owner_Email = i_owner_email and o.Customer = i_customer_email) > 0
then leave sp_main; end if;

INSERT INTO Owners_Rate_Customers VALUES (i_owner_email, i_customer_email, i_score);
end //
delimiter ;


-- ID: 7a
-- Name: view_airports
create or replace view view_airports (
    airport_id, 
    airport_name, 
    time_zone, 
    total_arriving_flights, 
    total_departing_flights, 
    avg_departing_flight_cost
) as
-- TODO: replace this select query with your solution    
select airport_id, airport_name, time_zone, ifnull(arrival_flights.arrivals,0),
ifnull(departure_flights.departures,0), cost_of_flight from airport left join
(select to_airport, count(to_airport) as arrivals from flight group by to_airport)
as arrival_flights on airport.airport_id = arrival_flights.to_airport left join 
(select from_airport, count(from_airport) as departures, avg(cost) as cost_of_flight from
flight group by from_airport) as departure_flights on airport.airport_id = departure_flights.from_airport;


-- ID: 7b
-- Name: view_airlines
create or replace view view_airlines (
    airline_name, 
    rating, 
    total_flights, 
    min_flight_cost
) as
-- TODO: replace this select query with your solution
select f.airline_name,rating, coalesce(count(f.airline_name),0), min(cost) from flight as f join airline as a 
on f.airline_name = a.airline_name group by f.airline_name;


-- ID: 8a
-- Name: view_customers
create or replace view view_customers (
    customer_name, 
    avg_rating, 
    location, 
    is_owner, 
    total_seats_purchased
) as
-- TODO: replace this select query with your solution
-- view customers
select customer_name, avg_rating, location,
if(owner_email is null , 0, 1), ifnull(total_seats_purchased,0) from
(select t1.email, customer_name, avg_rating, location, total_seats_purchased from
(select customer_name, locations.email, avg_rating, location from
(select customer.email, concat(first_name, " ", last_name) as customer_name, location 
from accounts right join customer on accounts.email = customer.email) as locations
left join
(select customer, avg(score) as avg_rating from owners_rate_customers group by customer) as scores
on locations.email = scores.customer) as t1
left join
(select customer, sum(num_seats) as total_seats_purchased from book group by customer) as seats
on t1.email = seats.customer) as t2
left outer join
(select email as owner_email from owners) as owners
on owner_email = t2.email;


-- ID: 8b
-- Name: view_owners
create or replace view view_owners (
    owner_name, 
    avg_rating, 
    num_properties_owned, 
    avg_property_rating
) as
-- TODO: replace this select query with your solution
select owner_name, avg_rating, ifnull(total_properties,0), avg_prop_rating from
(select t5.email, owner_name, avg_rating, total_properties from
(select t1.email, owner_name, avg_rating from 
(select owners.email, concat(first_name, " ", last_name) as owner_name from accounts join owners on accounts.email = owners.email) as t1
left join
(select owner_email, avg(score) as avg_rating from Customers_Rate_Owners group by owner_email) as t2
on t1.email = t2.owner_email) as t5
left join
(select owner_email, count(owner_email) as total_properties from property group by owner_email) as t3
on t5.email = t3.owner_email) as t6
left join
(select owner_email, avg(score) as avg_prop_rating from review group by owner_email) as t4
on t6.email = t4.owner_email;

-- ID: 9a
-- Name: process_date
drop procedure if exists process_date;
delimiter //
create procedure process_date ( 
    in i_current_date date
)
sp_main: begin
-- TODO: Implement your solution here
    
end //
delimiter ;
