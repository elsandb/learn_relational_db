# Relational Database Course Projects - [FreeCodeCamp](https://www.freecodecamp.org)

This repository contains projects completed as part of the FreeCodeCamp.org's [Relational Database course](https://www.freecodecamp.org/learn/relational-database). The course comprises 14 projects, of which 5 are compulsory to earn a certificate.


## Projects (directories) overview

| Directories      |Description        |
|------------------|-----------------------|
|**`./universe_database/`**| A database of celestial bodies, built with postgreSQL (`universe.sql`). <br><br>[ Not part of the freecodecamp course: An entity relationship diagram showing the tables and relationships (`universe_erd.jpg`). ] |
| **`./worldcup_db/`** | The project involved creating a Bash script (`insert_data.sh`) to import data from a csv-file (`games.csv`) into a PostgreSQL database named "worldcup". Additionally, a set of SQL queries (in `queries.sh`) were written to extract statistics from the database. |
| **`./salon_appointment_scheduler/`** | The Bash script `salon.sh`, combined with the PostgreSQL database `"salon"`, constitutes a simple booking/customer managment system for a salon.  |
| **`./periodic_table_database/`** | A Bash script (`element.sh`) that accepts one argument (an element's atomic number, symbol OR name) and prints some info about the chosen element to the terminal. The info is extracted from the Postgres database `"periodic_table"`. |
| **`./number_guessing_game/`** | A command-line number guessing game (`number_guess.sh`) that stores info about the users (number of games played and number of guesses in their best game) in a PostgreSQL database ("`number_guess`") |
|

See README.md files in each directory for more details.

---


### How to create a database from an .sql-file?

Use **psql**, the PostgreSQL command-line interface (CLI) for executing SQL commands:

- Run `psql -U <your PostgreSQL username> < database_file.sql` in a Bash. This assumes that database_file.sql is in your working directory. (The default username is "postgres". Use that if you are not sure.)

- Or like this
    ````shell
    # --- In bash shell ---

    # Login to postgres CLI
    psql --username=postgres --dbname=postgres

    # Create the database from database_file.sql
    \i full_path_to/database_file.sql

    # Example: 
    # \i /mnt/c/Users/.../salon_appointment_scheduler/salon.sql
    ````
