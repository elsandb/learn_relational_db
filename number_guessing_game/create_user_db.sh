#!/bin/bash
# Script to create user database for the number guessing game.

# Check if user database exist (https://stackoverflow.com/a/17757560/19325760)
USERS_DATABASE=$(psql --username=freecodecamp --dbname=postgres -XtAc "SELECT 1 FROM pg_database WHERE datname='number_guess'") # Return 1 if exists, return null if not exists.

# If database does not exist
if [[ "$USERS_DATABASE" != "1" ]]; then
    echo "Creating database"
    # Create database
    psql --username=freecodecamp --dbname=postgres -XtAc "CREATE DATABASE number_guess"
fi

# Connect to database
PSQL="psql --username=freecodecamp --dbname=number_guess --no-align --tuples-only --field-separator=, -c"

# Create table: users
$PSQL "
    CREATE TABLE IF NOT EXISTS users( 
        username VARCHAR(22) UNIQUE,
        games_played INT DEFAULT 0, 
        best_game INT DEFAULT 0
    );
"