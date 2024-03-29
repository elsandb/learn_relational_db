# Salon Appointment Scheduler <br>(customer managment system)

This project is part of a Relational Database course on **freecodecamp.org**. <br>
([Relational database learning path](https://www.freecodecamp.org/learn/relational-database))

> **Short project description from FreeCodeCamp:** <br>
*"For this project, you will create an interactive Bash program that uses PostgreSQL to track the customers and appointments for your salon."* ([Course site](https://www.freecodecamp.org/learn/relational-database/build-a-salon-appointment-scheduler-project/build-a-salon-appointment-scheduler))


## Description
The Bash script `salon.sh`, combined with the PostgreSQL database `salon`, constitutes a booking managment system for a salon (a system for managing customers and appointments within a salon). 


## Files

| File      |Description            |
|-----------|-----------------------|
| `./salon.sh`           | The script serves as a **command-line interface for customers to schedule appointments**. It provides a menu to select services and choose a suitable time for the appointment. The script interacts with the `salon database` to store customer's contact info and appointment details.                                                                                        |
| `./examples.txt`       | Contains examples of the terminal output of the `salon.sh` script. The file was provided as a course resource (i.e., it was created/written by freecodecamp.org).                                                                                           |
| `./salon.sql`          | Contains the SQL script for initializing and setting up the PostgreSQL database schema required for the salon management system. It includes table definitions, constraints, and sample data to populate the database with initial values. **Use this script to create the 'salon' database.**   |
|

## PostgreSQL Database (salon)
The "salon" PostgreSQL database stores information about customers, services, and appointments for the salon management system. It is utilized by the `salon.sh` script to store and retrieve data related to salon operations.

### Database Schema
The database schema includes the following tables:

- `customers`: Stores information about salon customers (name and phone number).
- `services`: Contains the name of the services offered by the salon.
- `appointments`: Records appointments scheduled by customers, including the customer ID, service ID, and appointment time.

### Connecting to the Database
The script connects to the "salon" database using the following credentials:

- Username: freecodecamp
- Database Name: salon

A PostgreSQL server must be accessible with these credentials for the salon.sh script to work. Or you can just change the username in the script with <your_username>. 


## Usage

#### Create the salon database
- Run `psql -U postgres < salon.sql` in the terminal to create the salon database. This assumes that `salon.sql` is in your working directory.

#### Run the salon.sh script without arguments
- Run `./salon.sh` in your Bash-compatible terminal.

<br>

---

<br>

*This file is written with help from chat.openai.*