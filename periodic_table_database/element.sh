#! /bin/bash

# This program will print info about an element in the periodic table.
# It accepts one argument, namely the element's
#   1) Atomic number (2)
#   2) Symbol ("He") 
#   OR 
#   3) Name ("Helium")

# Connect to database
PSQL="psql --username=postgres --dbname=periodic_table --no-align --tuples-only --field-separator=, -c"


# --- EXIT IF ... CHECK ARUMENTS FOR REASONS TO EXIT THE PROGRAM --- #
# If no argument passed
if [[ -z $1 ]]; then 
    echo "Please provide an element as an argument."

# # If number of arguments is more than 1
# elif (( $# > 1 )); then
#     echo -e "\nI received $# arguments. Please provide only one argument.
#     \nThe argument may be an element's:
#     - atomic_number (e.g., 2)
#     - symbol (\"He\")
#     or
#     - name (\"Helium\")\n"
# # If the argument contains space
# elif [[ $string =~ [[:space:]] ]]; then
#     echo "I recieved an argument containing a space. Please make sure there are no spaces in your argument."

else
  # --- GET ATOMIC_NUMBER - CHECK FOR MATCH IN DATABASE --- #
  # If $1 contains only digits
  if [[ "$1" =~ ^[0-9]+$ ]]; then
    # If argument in database (elements table)
    ATOMIC_NUMBER_RESULT=$($PSQL "
      SELECT atomic_number FROM elements 
      WHERE  atomic_number=$1
    ;")

  # If $1 contains only letters
  else
      ATOMIC_NUMBER_RESULT=$($PSQL "
        SELECT atomic_number FROM elements 
        WHERE   symbol=INITCAP('$1')
                OR name=INITCAP('$1')
      ;")
  fi
  

  # --- GET ELEMENT_INFO --- #
  # If a matching element was found in database
  if [[ $ATOMIC_NUMBER_RESULT ]]; then
      # Get element info from database
      element_info=$($PSQL "
          SELECT atomic_number, symbol, name, 
                  atomic_mass, melting_point_celsius, 
                  boiling_point_celsius, type
          FROM elements 
              FULL JOIN properties using(atomic_number) 
              FULL JOIN types using (type_id)
          WHERE atomic_number=$ATOMIC_NUMBER_RESULT
      ;")

      # Read element info
      echo "$element_info" | while IFS="," read -r ATOMIC_NR SYMBOL NAME MASS MELTING_POINT BOILING_POINT TYPE
      do
          # Print element info
          echo "The element with atomic number $ATOMIC_NR is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
      done
  # If no matching element was found in database
  else
      echo "I could not find that element in the database."
  fi

fi