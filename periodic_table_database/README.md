# Periodic Table Database
This project is part of a Relational Database course on **freecodecamp.org**. <br>
([Relational database learning path](https://www.freecodecamp.org/learn/relational-database))

> **Short project description from FreeCodeCamp:** <br>
*"For this project, you will create Bash a script to get information about chemical elements from a periodic table database."* ([Course site](https://www.freecodecamp.org/learn/relational-database/build-a-periodic-table-database-project/build-a-periodic-table-database))


## Description
The main script in this folder is `./element.sh`. The script accepts one argument, namely an element's
  1) Atomic number (e.g., 2)
  2) Symbol ("He") <br>
  OR 
  3) Name ("Helium")

and will output some info about the chosen element to the terminal. 

Example: If you want to get info about helium, run the script with the argument "2":

````bash
snow@snow:periodic_table_database$ ./element.sh 2

# OUTPUT:
# The element with atomic number 2 is Helium (He). It's a nonmetal, with a mass of 4.0026 amu. Helium has a melting point of -272.2 celsius and a boiling point of -269 celsius.
````

The database only contain 10 elements. 

## Files

| File      |Description            |
|-----------|-----------------------|
| `./element.sh` | A Bash script that accepts one argument (an element's atomic number, symbol OR name) and prints some info about the chosen element to the terminal. |
| `./periodic_table.sql` | Contains the SQL commands for setting up the database required for `element.sh` to work. Us this script to create the `periodic_table` database.|
| `./fix_database.sh` | A script that makes changes to the "starting database". The "starting database" was given as a course resource. In  `./fix_database.sh`, the "starting database" is altered, so that it meets the requirements (user stories) in the course instructions.|
|

## Usage

#### Create the periodic_table database
- Run `psql -U postgres < periodic_table.sql` in the terminal to create the periodic_table database. This assumes that `periodic_table.sql` is in your working directory.

#### Run the element.sh script
- In the Bash terminal: 
    - Make sure you have execute permission for `./element.sh`. If not, change mode by running `chmode +x element.sh`. 
    - Then run the script with an argument as described under [Description](#description).
