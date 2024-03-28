#!/bin/bash
# This script is a number guessing game where the user try to guess a 
# randomly generated number between 1 and 1000 (inclusive).

# Generate a random number between 0 and 1000 that the user have to guess.
RANDOM_NUMBER=$(( 1 + RANDOM % 1000 ))

# Connect to DB to keep track of users and their games
PSQL="psql -U freecodecamp -d number_guess -A --tuples-only --field-separator=, -c"

# Prompt for username
echo "Enter your username:"
read -r USERNAME_INPUT

# Check if user is already in DB
USER_INFO=$($PSQL "
    SELECT username, games_played, best_game 
    FROM users 
    WHERE username='$USERNAME_INPUT'
;")

# If user not in DB
if [[ -z "$USER_INFO" ]]; then
    # Print welcome new user message
    echo "Welcome, $USERNAME_INPUT! It looks like this is your first time here."
    # Add username to DB
    ADD_USER=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME_INPUT')")

    # If user not added successfully
    if [[ ! $ADD_USER = "INSERT 0 1" ]]; then
        echo "I am sorry, I could not add you to the database."
        
    # If user added successfully
    else
        # Get user info
        USER_INFO=$($PSQL "
            SELECT username, games_played, best_game 
            FROM users 
            WHERE username='$USERNAME_INPUT'
        ;")
        IFS="," read -r USERNAME GAMES_PLAYED BEST_GAME <<< "$USER_INFO"
    fi

# If user in DB
else
    # Get user info
    IFS="," read -r USERNAME GAMES_PLAYED BEST_GAME <<< "$USER_INFO"
    # Thanks to https://www.manniwood.com/postgresql_and_bash_stuff/#:~:text=How%20to%20get%20a%20one%20row%20select%20into%20bash%20variables%20named%20for%20each%20column%20in%20the%20row

    # Print Welcome statement
    echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
fi


# Ask user to guess
echo "Guess the secret number between 1 and 1000:"
read -r GUESS
while [[ ! $GUESS =~ ^[0-9]+$ ]]; do
    # Guess again, not increase NR_OF_TRIES count
    echo "That is not an integer, guess again:"
    read -r GUESS
done

NR_OF_TRIES=1
while [[ "$GUESS" -ne "$RANDOM_NUMBER" ]]; do
    # If GUESS is NOT an integer
    if [[ ! $GUESS =~ ^[0-9]+$ ]]; then
        # Guess again, not increase NR_OF_TRIES count
        echo "That is not an integer, guess again:"
        read -r GUESS
    
    # If guess is greater or smaller than the random nr - guess again, increase tries count
    elif [[ $GUESS -gt $RANDOM_NUMBER ]]; then
        echo "It's lower than that, guess again:"
        (( NR_OF_TRIES += 1))
        read -r GUESS
    elif [[ $GUESS -lt $RANDOM_NUMBER ]]; then
        echo "It's higher than that, guess again:"
        (( NR_OF_TRIES += 1))
        read -r GUESS
    fi
done

# Print message when guess is correct
echo "You guessed it in $NR_OF_TRIES tries. The secret number was $RANDOM_NUMBER. Nice job!"


# Update GAMES_PLAYED: Increase number of games played by 1
INC_GAMES_PLAYED=$($PSQL "UPDATE users SET games_played = games_played + 1 WHERE username='$USERNAME'")

# Update BEST_GAME
# If this is the players first game (i.e., when best number of guesses is 0)
# OR if the user has played before but NR_OF_TRIES is better than BEST_GAME
if [[ $BEST_GAME = 0 ]] || [[ $NR_OF_TRIES -lt $BEST_GAME ]]; then
    # Set number of guesses from current game as best_game
    UPDATE_BEST_GAME=$($PSQL "UPDATE users SET best_game = $NR_OF_TRIES WHERE username='$USERNAME'")
fi
