# Number Guessing Game
This project is part of a Relational Database course on **freecodecamp.org**. <br>
([Relational database learning path](https://www.freecodecamp.org/learn/relational-database))

> **Short project description from FreeCodeCamp:** <br>
*"For this project, you will use Bash scripting, PostgreSQL, and Git to create a number guessing game that runs in the terminal and saves user information."*
([Course site](https://www.freecodecamp.org/learn/relational-database/build-a-number-guessing-game-project/build-a-number-guessing-game))


This folder contains a bash script for a number guessing game, that also keeps track of some user info: 
- username
- number of games played
- number of tries (guesses) in their best game

The info is stored in a postgreSQL database.

## Files

| File      |Description            |
|-----------|-----------------------|
| `number_guess.sh` | A number guessing game script where the user try to guess a randomly generated number between 1 and 1000 (inclusive).|
| `create_user_db.sh` | Script to create user database needed in `number_guess.sh`.|
| `number_guess.sql` | File that can be used to build the database needed in `number_guess.sh`.|
|


## Usage

To play the game... 

first, create the database:
- Build it from `number_guess.sql` by running `psql -U postgres < number_guess.sql` in bash terminal.

    **OR**

- Use `./create_user_db.sh` to create the database:
    - Run `chmod +x create_user_db.sh` to give yourself execute permission.
    - Before running the script, change the username to *your* username. I.e., open the script and check all places that says `--username=freecodecamp`. Replace `freecodecamp` with *your* username (if you are a noob like me, this will probably be the default PostgreSQL username `postgres`). Replace `postgres` with the name.
    - Run `./create_user_db.sh`

Then, in a Bash terminal:
- Run `chmod +x number_guess.sh` to grant yourself execute permission.
- Run `./number_guess.sh` to start the game.
