DROP DATABASE IF EXISTS travelReservationService;
CREATE DATABASE IF NOT EXISTS travelReservationService;
USE travelReservationService;

DROP TABLE IF EXISTS Accounts;
CREATE TABLE Accounts (
email varchar(50) NOT NULL,
password varchar(50) NOT NULL,
fname varchar(100) NOT NULL,
lname varchar(100) NOT NULL,
PRIMARY KEY (email)
) ENGINE=InnoDB;

INSERT INTO Accounts VALUES
('mmoss1@travelagency.com','password1','Mark','Moss'),('asmith@travelagency.com','password2','Aviva','Smith'),('mscott22@gmail.com','password3','Michael','Scott'),('arthurread@gmail.com','password4','Arthur','Read'),('jwayne@gmail.com','password5','John','Wayne'),('gburdell3@gmail.com','password6','George','Burdell'),('mj23@gmail.com','password7','Michael','Jordan'),('lebron6@gmail.com','password8','Lebron','James'),('msmith5@gmail.com','password9','Michael','Smith'),('ellie2@gmail.com','password10','Ellie','Johnson'),('scooper3@gmail.com','password11','Sheldon','Cooper'),('mgeller5@gmail.com','password12','Monica','Geller'),('cbing10@gmail.com','password13','Chandler','Bing'),('hwmit@gmail.com','password14','Howard','Wolowitz'),('swilson@gmail.com','password16','Samantha','Wilson'),('aray@tiktok.com','password17','Addison','Ray'),('cdemilio@tiktok.com','password18','Charlie','Demilio'),('bshelton@gmail.com','password19','Blake','Shelton'),('lbryan@gmail.com','password20','Luke','Bryan'),('tswift@gmail.com','password21','Taylor','Swift'),('jseinfeld@gmail.com','password22','Jerry','Seinfeld'),('maddiesmith@gmail.com','password23','Madison','Smith'),('johnthomas@gmail.com','password24','John','Thomas'),('boblee15@gmail.com','password25','Bob','Lee');

DROP TABLE IF EXISTS Administrator;
CREATE TABLE Administrator (
email varchar(50),
PRIMARY KEY (email),
CONSTRAINT administrator_ibfk_1 FOREIGN KEY (email) REFERENCES Accounts(email)
) ENGINE=InnoDB;

INSERT INTO Administrator VALUES
('mmoss1@travelagency.com'), ('asmith@travelagency.com');

DROP TABLE IF EXISTS Clients;
CREATE TABLE Clients (
email varchar(50),
phone_number char(12),
UNIQUE KEY phone_number (phone_number),
PRIMARY KEY (email),
CONSTRAINT clients_ibfk_1 FOREIGN KEY (email) REFERENCES Accounts(email)
)ENGINE=InnoDB;

INSERT INTO Clients VALUES
('mscott22@gmail.com','555-123-4567'),('arthurread@gmail.com','555-234-5678'),('jwayne@gmail.com','555-345-6789'),('gburdell3@gmail.com','555-456-7890'),('mj23@gmail.com','555-567-8901'),('lebron6@gmail.com','555-678-9012'),('msmith5@gmail.com','555-789-0123'),('ellie2@gmail.com','555-890-1234'),('scooper3@gmail.com','678-123-4567'),('mgeller5@gmail.com','678-234-5678'),('cbing10@gmail.com','678-345-6789'),('hwmit@gmail.com','678-456-7890'),('swilson@gmail.com','770-123-4567'),('aray@tiktok.com','770-234-5678'),('cdemilio@tiktok.com','770-345-6789'),('bshelton@gmail.com','770-456-7890'),('lbryan@gmail.com','770-567-8901'),('tswift@gmail.com','770-678-9012'),('jseinfeld@gmail.com','770-789-0123'),('maddiesmith@gmail.com','770-890-1234'),('johnthomas@gmail.com','404-770-5555'),('boblee15@gmail.com','404-678-5555');

DROP TABLE IF EXISTS Customer;
CREATE TABLE Customer (
email varchar(50),
ccnum char(19) NOT NULL,
cvv numeric(3) NOT NULL,
exp_date varchar(11) NOT NULL,
current_location varchar(50) NULL,
PRIMARY KEY(email),
CONSTRAINT customer_ibfk_1 FOREIGN KEY (email) REFERENCES Clients(email)
)ENGINE=InnoDB;

INSERT INTO Customer VALUES
('scooper3@gmail.com','65185 559 7446 1663',551,' Feb 2024','nan'),('mgeller5@gmail.com','2328 5670 4310 1965',644,' March 2024','nan'),('cbing10@gmail.com','8387 9523 9827 9291',201,' Feb 2023','nan'),('hwmit@gmail.com','6558 8596 9852 5299',102,' April 2023','nan'),('swilson@gmail.com','9383 3212 4198 1836',455,' Aug 2022','nan'),('aray@tiktok.com','3110 2669 7949 5605',744,' Aug 2022','nan'),('cdemilio@tiktok.com','2272 3555 4078 4744',606,' Feb 2025','nan'),('bshelton@gmail.com','9276 7639 7883 4273',862,' Sept 2023','nan'),('lbryan@gmail.com','4652 3726 8864 3798',258,' May 2023','nan'),('tswift@gmail.com','5478 8420 4436 7471',857,' Dec 2024','nan'),('jseinfeld@gmail.com','3616 8977 1296 3372',295,' June 2022','nan'),('maddiesmith@gmail.com','9954 5698 6355 6952',794,' July 2022','nan'),('johnthomas@gmail.com','7580 3274 3724 5356',269,' Oct 2025','nan'),('boblee15@gmail.com','7907 3513 7161 4248',858,' Nov 2025','nan');

DROP TABLE IF EXISTS Owners;
CREATE TABLE Owners (
email varchar(50),
phone_number varchar(12),
PRIMARY KEY (email),
CONSTRAINT owners_ibfk_1 FOREIGN KEY (email) REFERENCES Clients(email)
)ENGINE=InnoDB;

INSERT INTO Owners VALUES
('mscott22@gmail.com','555-123-4567'),('arthurread@gmail.com','555-234-5678'),('jwayne@gmail.com','555-345-6789'),('gburdell3@gmail.com','555-456-7890'),('mj23@gmail.com','555-567-8901'),('lebron6@gmail.com','555-678-9012'),('msmith5@gmail.com','555-789-0123'),('ellie2@gmail.com','555-890-1234'),('scooper3@gmail.com','678-123-4567'),('mgeller5@gmail.com','678-234-5678'),('cbing10@gmail.com','678-345-6789'),('hwmit@gmail.com','678-456-7890');


DROP TABLE IF EXISTS Rates;
CREATE TABLE Rates (
owner_email varchar(50) NOT NULL,
customer_email varchar(50) NOT NULL,
score decimal(1,0) DEFAULT NULL,
CONSTRAINT rates_ibfk_1 FOREIGN KEY (owner_email) REFERENCES Owners(email),
CONSTRAINT rates_ibfk_2 FOREIGN KEY (customer_email) REFERENCES Customer(email),
CONSTRAINT checkRatings1 CHECK (score > 0 AND score <= 5)
)ENGINE=InnoDB;

INSERT INTO Rates VALUES
('gburdell3@gmail.com','swilson@gmail.com',5),('cbing10@gmail.com','aray@tiktok.com',5),('mgeller5@gmail.com','bshelton@gmail.com',3),('arthurread@gmail.com','lbryan@gmail.com',4),('arthurread@gmail.com','tswift@gmail.com',4),('lebron6@gmail.com','jseinfeld@gmail.com',1),('hwmit@gmail.com','maddiesmith@gmail.com',2);

DROP TABLE IF EXISTS RateBy;
CREATE TABLE RateBy (
owner_email varchar(50) NOT NULL,
customer_email varchar(50) NOT NULL,
score decimal(1,0) DEFAULT NULL,
CONSTRAINT rateby_ibfk_1 FOREIGN KEY (owner_email) REFERENCES Owners(email),
CONSTRAINT rateby_ibfk_2 FOREIGN KEY (customer_email) REFERENCES Customer(email),
CONSTRAINT checkRatings2 CHECK (score > 0 AND score <= 5)
)ENGINE=InnoDB;

INSERT INTO RateBy VALUES
('gburdell3@gmail.com','swilson@gmail.com',5),('cbing10@gmail.com','aray@tiktok.com',5),('mgeller5@gmail.com','bshelton@gmail.com',4),('arthurread@gmail.com','lbryan@gmail.com',4),('arthurread@gmail.com','tswift@gmail.com',3),('lebron6@gmail.com','jseinfeld@gmail.com',2),('hwmit@gmail.com','maddiesmith@gmail.com',5);



DROP TABLE IF EXISTS Properties;
CREATE TABLE Properties (
name varchar(50) NOT NULL,
description varchar(300) NOT NULL,
owner_email varchar(50) NOT NULL,
street varchar(50) NOT NULL,
city varchar(50) NOT NULL,
state varchar(50) NOT NULL,
zip decimal(5,0) NOT NULL,
nightly_cost decimal(10,2) NOT NULL,
capacity decimal(3,0)  NOT NULL,
PRIMARY KEY (name, owner_email),
CONSTRAINT address UNIQUE (street, city, state, zip),
CONSTRAINT property_ibfk_1 FOREIGN KEY (owner_email) REFERENCES Owners(email)
)ENGINE=InnoDB;

INSERT INTO Properties VALUES
('Atlanta Great Property','This is right in the middle of Atlanta near many attractions!','scooper3@gmail.com','2nd St','ATL','GA',30008,600,4),('House near Georgia Tech','Super close to bobby dodde stadium!','gburdell3@gmail.com','North Ave','ATL','GA',30008,275,3),('New York City Property','A view of the whole city. Great property!','cbing10@gmail.com','123 Main St','NYC','NY',10008,750,2),('Statue of Libery Property','You can see the statue of liberty from the porch','mgeller5@gmail.com','1st St','NYC','NY',10009,1000,5),('Los Angeles Property','nan','arthurread@gmail.com','10th St','LA','CA',90008,700,3),('LA Kings House','This house is super close to the LA kinds stadium!','arthurread@gmail.com','Kings St','La','CA',90011,750,4),('Beautiful San Jose Mansion','Huge house that can sleep 12 people. Totally worth it!','arthurread@gmail.com','Golden Bridge Pkwt','San Jose','CA',90001,900,12),('LA Lakers Property','This house is right near the LA lakers stadium. You might even meet Lebron James!','lebron6@gmail.com','Lebron Ave','LA','CA',90011,850,4),('Chicago Blackhawks House','This is a great property!','hwmit@gmail.com','Blackhawks St','Chicago','IL',60176,775,3),('Chicago Romantic Getaway','This is a great property!','mj23@gmail.com','23rd Main St','Chicago','IL',60176,1050,2),('Beautiful Beach Property','You can walk out of the house and be on the beach!','msmith5@gmail.com','456 Beach Ave','Miami','FL',33101,975,2),('Family Beach House','You can literally walk onto the beach and see it from the patio!','ellie2@gmail.com','1132 Beach Ave','Miami','FL',33101,850,6),('Texas Roadhouse','This property is right in the center of Dallas, Texas!','mscott22@gmail.com','17th Street','Dallas','TX',75043,450,3),('Texas Longhorns House','You can walk to the longhorns stadium from here!','mscott22@gmail.com','1125 Longhorns Way','Dallas','TX',75001,600,10);


DROP TABLE IF EXISTS Amenities;
CREATE TABLE Amenities (
property_name varchar(50) NOT NULL,
owner_email varchar(50) NOT NULL,
amenity varchar(50) NOT NULL,
PRIMARY KEY (owner_email, property_name, amenity),
CONSTRAINT amenities_ibfk_1 FOREIGN KEY (property_name, owner_email) REFERENCES Properties(name, owner_email)
)ENGINE=InnoDB;

INSERT INTO Amenities VALUES
('Atlanta Great Property','scooper3@gmail.com','A/C & Heating'),('Atlanta Great Property','scooper3@gmail.com','Pets allowed'),('Atlanta Great Property','scooper3@gmail.com','Wifi & TV'),('Atlanta Great Property','scooper3@gmail.com','Washer and Dryer'),('House near Georgia Tech','gburdell3@gmail.com','Wifi & TV'),('House near Georgia Tech','gburdell3@gmail.com','Washer and Dryer'),('House near Georgia Tech','gburdell3@gmail.com','Full Kitchen'),('New York City Property','cbing10@gmail.com','A/C & Heating'),('New York City Property','cbing10@gmail.com','Wifi & TV'),('Statue of Libery Property','mgeller5@gmail.com','A/C & Heating'),('Statue of Libery Property','mgeller5@gmail.com','Wifi & TV'),('Los Angeles Property','arthurread@gmail.com','A/C & Heating'),('Los Angeles Property','arthurread@gmail.com','Pets allowed'),('Los Angeles Property','arthurread@gmail.com','Wifi & TV'),('LA Kings House','arthurread@gmail.com','A/C & Heating'),('LA Kings House','arthurread@gmail.com','Wifi & TV'),('LA Kings House','arthurread@gmail.com','Washer and Dryer'),('LA Kings House','arthurread@gmail.com','Full Kitchen'),('Beautiful San Jose Mansion','arthurread@gmail.com','A/C & Heating'),('Beautiful San Jose Mansion','arthurread@gmail.com','Pets allowed'),('Beautiful San Jose Mansion','arthurread@gmail.com','Wifi & TV'),('Beautiful San Jose Mansion','arthurread@gmail.com','Washer and Dryer'),('Beautiful San Jose Mansion','arthurread@gmail.com','Full Kitchen'),('LA Lakers Property','lebron6@gmail.com','A/C & Heating'),('LA Lakers Property','lebron6@gmail.com','Wifi & TV'),('LA Lakers Property','lebron6@gmail.com','Washer and Dryer'),('LA Lakers Property','lebron6@gmail.com','Full Kitchen'),('Chicago Blackhawks House','hwmit@gmail.com','A/C & Heating'),('Chicago Blackhawks House','hwmit@gmail.com','Wifi & TV'),('Chicago Blackhawks House','hwmit@gmail.com','Washer and Dryer'),('Chicago Blackhawks House','hwmit@gmail.com','Full Kitchen'),('Chicago Romantic Getaway','mj23@gmail.com','A/C & Heating'),('Chicago Romantic Getaway','mj23@gmail.com','Wifi & TV'),('Beautiful Beach Property','msmith5@gmail.com','A/C & Heating'),('Beautiful Beach Property','msmith5@gmail.com','Wifi & TV'),('Beautiful Beach Property','msmith5@gmail.com','Washer and Dryer'),('Family Beach House','ellie2@gmail.com','A/C & Heating'),('Family Beach House','ellie2@gmail.com','Pets allowed'),('Family Beach House','ellie2@gmail.com','Wifi & TV'),('Family Beach House','ellie2@gmail.com','Washer and Dryer'),('Family Beach House','ellie2@gmail.com','Full Kitchen'),('Texas Roadhouse','mscott22@gmail.com','A/C & Heating'),('Texas Roadhouse','mscott22@gmail.com','Pets allowed'),('Texas Roadhouse','mscott22@gmail.com','Wifi & TV'),('Texas Roadhouse','mscott22@gmail.com','Washer and Dryer'),('Texas Longhorns House','mscott22@gmail.com','A/C & Heating'),('Texas Longhorns House','mscott22@gmail.com','Pets allowed'),('Texas Longhorns House','mscott22@gmail.com','Wifi & TV'),('Texas Longhorns House','mscott22@gmail.com','Washer and Dryer'),('Texas Longhorns House','mscott22@gmail.com','Full Kitchen');


DROP TABLE IF EXISTS Review;
CREATE TABLE Review (
property_name varchar(50) NOT NULL,
customer_email varchar(50) NOT NULL,
owner_email varchar(50) NOT NULL,
content varchar(500) DEFAULT NULL,
score decimal(1,0) DEFAULT NULL,
PRIMARY KEY (property_name, customer_email, owner_email),
CONSTRAINT review_ibfk_1 FOREIGN KEY (customer_email) REFERENCES Customer(email),
CONSTRAINT review_ibfk_2 FOREIGN KEY (property_name, owner_email) REFERENCES Properties(name, owner_email),
CONSTRAINT checkRating3 CHECK (score > 0 AND score <= 5)
)ENGINE=InnoDB;

INSERT INTO Review VALUES
('House near Georgia Tech','swilson@gmail.com','gburdell3@gmail.com','This was so much fun. I went and saw the coke factory, the falcons play, GT play, and the Georgia aquarium. Great time! Would highly recommend!',5),('New York City Property','aray@tiktok.com','cbing10@gmail.com','This was the best 5 days ever! I saw so much of NYC!',5),('Statue of Libery Property','bshelton@gmail.com','mgeller5@gmail.com','This was truly an excellent experience. I really could see the Statue of Liberty from the property!',4),('Los Angeles Property','lbryan@gmail.com','arthurread@gmail.com','I had an excellent time!',4),('Beautiful San Jose Mansion','tswift@gmail.com','arthurread@gmail.com',"We had a great time, but the house wasn't fully cleaned when we arrived",3),('LA Lakers Property','jseinfeld@gmail.com','lebron6@gmail.com','I was disappointed that I did not meet lebron james',2),('Chicago Blackhawks House','maddiesmith@gmail.com','hwmit@gmail.com','This was awesome! I met one player on the chicago blackhawks!',5);

DROP TABLE IF EXISTS Airlines;
CREATE TABLE Airlines (
name varchar(50) NOT NULL,
rating decimal(2,1),
PRIMARY KEY (name),
CONSTRAINT checkRatings4 CHECK (rating >= 0 AND rating <= 5)
)ENGINE=InnoDB;

INSERT INTO Airlines VALUES
('Delta Airlines',4.7),('Southwest Airlines',4.4),('American Airlines',4.6),('United Airlines',4.2),('JetBlue Airways',3.6),('Spirit Airlines',3.3),('WestJet',3.9),('Interjet',3.7);

DROP TABLE IF EXISTS Airport;
CREATE TABLE Airport (
airportID varchar(3) NOT NULL,
airport_name varchar(50) NOT NULL,
street varchar(50) NOT NULL,
city varchar(50) NOT NULL,
state char(2) NOT NULL,
zip decimal(5,0) NOT NULL,
time_zone varchar(50) NOT NULL,
PRIMARY KEY (airportID),
UNIQUE KEY airport_name (airport_name),
CONSTRAINT address UNIQUE (street, city, state, zip)
)ENGINE=InnoDB;

INSERT INTO Airport VALUES
('ATL','Atlanta Hartsfield Jackson Airport','6000 N Terminal Pkwy','Atlanta','GA',30320,'EST'),('JFK','John F Kennedy International Airport','455 Airport Ave','Queens','NY',11430,'EST'),('LGA','Laguardia Airport','790 Airport St','Queens','NY',11371,'EST'),('LAX','Lost Angeles International Airport','1 World Way','Los Angeles','CA',90045,'PST'),('SJC','Norman Y. Mineta San Jose International Airport','1702 Airport Blvd','San Jose','CA',95110,'PST'),('ORD',"O'Hare International Airport","10000 W O'Hare Ave",'Chicago','IL',60666,'CST'),('MIA','Miami International Airport','2100 NW 42nd Ave','Miami','FL',33126,'EST'),('DFW','Dallas International Airport','2400 Aviation DR','Dallas','TX',75261,'CST');

DROP TABLE IF EXISTS Flight;
CREATE TABLE Flight (
airline_name varchar(50) NOT NULL,
flight_num varchar(5) NOT NULL,
departure_time varchar(9) NOT NULL,
arrival_time varchar(9) NOT NULL,
depature_airportID varchar(50) NOT NULL,
arrival_airportID varchar(50) NOT NULL,
date date NOT NULL,
seat_cost decimal(10,2) NOT NULL,
capacity decimal(10,0) NOT NULL,
PRIMARY KEY (flight_num, airline_name),
CONSTRAINT flight_ibfk_1 FOREIGN KEY (airline_name) REFERENCES Airlines(name),
CONSTRAINT flight_ibfk_2 FOREIGN KEY (depature_airportID) REFERENCES Airport(airportID),
CONSTRAINT flight_ibfk_3 FOREIGN KEY (arrival_airportID) REFERENCES Airport(airportID)
)ENGINE=InnoDB;

INSERT INTO Flight VALUES
('Delta Airlines',1,' 10:00 AM',' 12:00 PM','ATL','JFK','2021-10-18 00:00:00',400,150),('Southwest Airlines',2,' 10:30 AM',' 2:30 PM','ORD','MIA','2021-10-18 00:00:00',350,125),('American Airlines',3,' 1:00 PM',' 4:00 PM','MIA','DFW','2021-10-18 00:00:00',350,125),('United Airlines',4,' 4:30 PM',' 6:30 PM','ATL','LGA','2021-10-18 00:00:00',400,100),('JetBlue Airways',5,' 11:00 AM',' 1:00 PM','LGA','ATL','2021-10-19 00:00:00',400,130),('Spirit Airlines',6,' 12:30 PM',' 9:30 PM','SJC','ATL','2021-10-19 00:00:00',650,140),('WestJet',7,' 1:00 PM',' 4:00 PM','LGA','SJC','2021-10-19 00:00:00',700,100),('Interjet',8,' 7:30 PM',' 9:30 PM','MIA','ORD','2021-10-19 00:00:00',350,125),('Delta Airlines',9,' 8:00 AM',' 10:00 AM','JFK','ATL','2021-10-20 00:00:00',375,150),('Delta Airlines',10,' 9:15 AM',' 6:15 PM','LAX','ATL','2021-10-20 00:00:00',700,110),('Southwest Airlines',11,' 12:07 PM',' 7:07 PM','LAX','ORD','2021-10-20 00:00:00',600,95),('United Airlines',12,' 3:35 PM',' 5:35 PM','MIA','ATL','2021-10-20 00:00:00',275,115);


DROP TABLE IF EXISTS FlightBook;
CREATE TABLE FlightBook (
customer_email varchar(50) NOT NULL,
flight_num varchar(50) NOT NULL,
airline_name varchar(50) NOT NULL,
num_of_seats decimal(3,0) NOT NULL,
PRIMARY KEY (customer_email, flight_num, airline_name),
CONSTRAINT flightbook_ibfk_1 FOREIGN KEY (customer_email) REFERENCES Customer(email),
CONSTRAINT flightbook_ibfk_2 FOREIGN KEY (flight_num) REFERENCES Flight(flight_num),
CONSTRAINT flightbook_ibfk_3 FOREIGN KEY (airline_name) REFERENCES Airlines(name)
)ENGINE=InnoDB;

INSERT INTO FlightBook VALUES
('swilson@gmail.com',5,'JetBlue Airways',3),('aray@tiktok.com',1,'Delta Airlines',2),('bshelton@gmail.com',4,'United Airlines',4),('lbryan@gmail.com',7,'WestJet',2),('tswift@gmail.com',7,'WestJet',2),('jseinfeld@gmail.com',7,'WestJet',4),('maddiesmith@gmail.com',8,'Interjet',2),('cbing10@gmail.com',2,'Southwest Airlines',2),('hwmit@gmail.com',2,'Southwest Airlines',5);


DROP TABLE IF EXISTS PropertyCloseTo;
CREATE TABLE PropertyCloseTo (
property_name varchar(50) NOT NULL,
owner_email varchar(50) NOT NULL,
airportID varchar(50) NOT NULL,
distance decimal(8,2) DEFAULT NULL,
PRIMARY KEY (property_name, owner_email, airportID),
CONSTRAINT propertycloseto_ibfk_1 FOREIGN KEY (airportID) REFERENCES Airport(airportID),
CONSTRAINT propertycloseto_ibfk_2 FOREIGN KEY (property_name, owner_email) REFERENCES Properties (name, owner_email)
)ENGINE=InnoDB;

INSERT INTO PropertyCloseTo VALUES
('Atlanta Great Property','scooper3@gmail.com','ATL',12),('House near Georgia Tech','gburdell3@gmail.com','ATL',7),('New York City Property','cbing10@gmail.com','JFK',10),('Statue of Libery Property','mgeller5@gmail.com','JFK',8),('New York City Property','cbing10@gmail.com','LGA',25),('Statue of Libery Property','mgeller5@gmail.com','LGA',19),('Los Angeles Property','arthurread@gmail.com','LAX',9),('LA Kings House','arthurread@gmail.com','LAX',12),('Beautiful San Jose Mansion','arthurread@gmail.com','SJC',8),('Beautiful San Jose Mansion','arthurread@gmail.com','LAX',30),('LA Lakers Property','lebron6@gmail.com','LAX',6),('Chicago Blackhawks House','hwmit@gmail.com','ORD',11),('Chicago Romantic Getaway','mj23@gmail.com','ORD',13),('Beautiful Beach Property','msmith5@gmail.com','MIA',21),('Family Beach House','ellie2@gmail.com','MIA',19),('Texas Roadhouse','mscott22@gmail.com','DFW',8),('Texas Longhorns House','mscott22@gmail.com','DFW',17);


DROP TABLE IF EXISTS Reserve;
CREATE TABLE Reserve (
property_name varchar(50) NOT NULL,
owner_email varchar(50) NOT NULL,
customer_email varchar(50) NOT NULL,
start_date date NOT NULL,
end_date date NOT NULL,
num_of_guests decimal(3,0) NOT NULL,
PRIMARY KEY (property_name, owner_email, customer_email),
CONSTRAINT reserve_ibfk_1 FOREIGN KEY (property_name,owner_email) REFERENCES Properties(name,owner_email),
CONSTRAINT reserve_ibfk_2 FOREIGN KEY (customer_email) REFERENCES Customer(email)
)ENGINE=InnoDB;

INSERT INTO Reserve VALUES
('House near Georgia Tech','gburdell3@gmail.com','swilson@gmail.com','2021-10-19','2021-10-25',3),('New York City Property','cbing10@gmail.com','aray@tiktok.com','2021-10-18','2021-10-23',2),('New York City Property','cbing10@gmail.com','cdemilio@tiktok.com','2021-10-24','2021-10-30',2),('Statue of Libery Property','mgeller5@gmail.com','bshelton@gmail.com','2021-10-18','2021-10-22',4),('Los Angeles Property','arthurread@gmail.com','lbryan@gmail.com','2021-10-19','2021-10-25',2),('Beautiful San Jose Mansion','arthurread@gmail.com','tswift@gmail.com','2021-10-19','2021-10-22',10),('LA Lakers Property','lebron6@gmail.com','jseinfeld@gmail.com','2021-10-19','2021-10-24',4),('Chicago Blackhawks House','hwmit@gmail.com','maddiesmith@gmail.com','2021-10-19','2021-10-23',2),('Chicago Romantic Getaway','mj23@gmail.com','aray@tiktok.com','2021-11-01','2021-11-07',2),('Beautiful Beach Property','msmith5@gmail.com','cbing10@gmail.com','2021-10-18','2021-10-25',2),('Family Beach House','ellie2@gmail.com','hwmit@gmail.com','2021-10-18','2021-10-28',5);

