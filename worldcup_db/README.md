# World Cup Database

This project is part of a Relational Database course on **freecodecamp.org**. <br>([Relational database learning path](https://www.freecodecamp.org/learn/relational-database))

> **Short project description from FreeCodeCamp:** <br>
*"For this project, you will create a Bash script that enters information from World Cup games into PostgreSQL, then query the database for useful statistics."* ([Course site](https://www.freecodecamp.org/learn/relational-database/build-a-world-cup-database-project/build-a-world-cup-database))


___



| Projects      |Description        |
|-----------|-----------------------|
| **`./insert_data.sh`** | A bash script that read information from `./games.csv` and enters it into a PostgreSQL database called `"worldcup"`. |
| **`./worldcup.sql`** | A dump of the worldcup database with info from `./games.csv`. This file was created by running `pg_dump -cC --inserts -U <my_username> worldcup > worldcup.sql`, after running `./insert_data.sh`. <br><br>Rebuild the database with `psql -U <your_username> < worldcup.sql` in a Bash terminal. |
| **`./games.csv`** | Contains information about the final three rounds of the World Cup tournament in 2014 and 2018. This files is created by freecodecamp.org and given as a course resource. |
| **`./queries.sh`** | A script that query the database. The output in the terminal should be the same as in `./expected_output.txt`.|
| **`./expected_output.txt`** | A text-file showing the expected output from running `./queries.sh`. This files is created by freecodecamp.org and was part of the course resources.|