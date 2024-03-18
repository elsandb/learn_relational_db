#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

# Delet the data in the tables each time the script runs.
echo $($PSQL "TRUNCATE teams, games")

cat games.csv | while IFS="," read YEAR ROUND WIN OP WIN_GOALS OP_GOALS; do
    echo -e "\n$WIN --- $OP"
    if [[ $YEAR != "year" ]]; then # Skip headers start

        # ADD WINNER TEAM NAME TO THE TEAMS TABLE
        INSERT_WIN=$($PSQL "
            INSERT INTO teams (name) SELECT '$WIN'
            WHERE NOT EXISTS
                (SELECT * FROM teams WHERE name='$WIN')
            ")

        if [[ $INSERT_WIN = "INSERT 0 1" ]]; then
            echo -e "Insert into teams: $WIN"
        else
            echo "............"
        fi
        # ADD OPPONENT TEAM NAME TO THE TEAMS TABLE
        INSERT_OP=$($PSQL "
            INSERT INTO teams (name) SELECT '$OP'
            WHERE NOT EXISTS
                (SELECT * FROM teams WHERE name='$OP')
            ")
        if [[ $INSERT_OP = "INSERT 0 1" ]]; then
            echo -e "Insert into teams: $OP"
        else
            echo "............"
        fi

        # ADD year, round, winner_goals, opponent_goals, winner_id, opponent_id TO THE games TABLE.
        WIN_ID=$($PSQL "SELECT team_id FROM teams WHERE name ILIKE('$WIN')")
        OP_ID=$($PSQL "SELECT team_id FROM teams WHERE name ILIKE('$OP')")
        INSERT_GAME_DETAILS=$($PSQL "
            INSERT INTO games 
                (year, 
                round, 
                winner_goals, 
                opponent_goals, 
                winner_id, 
                opponent_id)
            VALUES
                ($YEAR, 
                '$ROUND', 
                $WIN_GOALS, 
                $OP_GOALS, 
                $WIN_ID,
                $OP_ID)
        ")
        if [[ $INSERT_GAME_DETAILS = "INSERT 0 1" ]]; then
            echo -e "Insert into games: $YEAR, $ROUND, $WIN, $OP, $WIN_GOALS, $OP_GOALS"
        fi

    fi # Skip headers done
done
