#! /bin/bash
PSQL="psql --username=freecodecamp --dbname=salon --tuples-only -c"

MAIN_MENU() {
    if [[ $1 ]]; then
        echo -e "$1"
    else
      echo -e "\n~~~~~ MOUSTACHE SALON ~~~~~\n\nWelcome, how can I help you?\n"
    fi

    # Get and print available services
    ALL_SERVICES=$($PSQL "SELECT service_id, name FROM services")
    echo "$ALL_SERVICES" | while read -r SERVICE_ID BAR SERVICE_NAME 
    do
        echo -e "$SERVICE_ID) $SERVICE_NAME"
    done

    # Get selected service id
    read SERVICE_ID_SELECTED

    # If input (selected service id) is not a number, go to MAIN_MENU
    if [[ ! $SERVICE_ID_SELECTED =~ ^[0-9]+$ ]]; then
        MAIN_MENU "\nThat is not a valid service id. Please enter a number."
    else
      # Check if SERVICE_ID_SELECTED is in database
      SERVICE_CHOSEN=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")
      # If the chosen service is NOT in database, go to MAIN_MENU
      if [[ -z $SERVICE_CHOSEN ]]; then
          MAIN_MENU "\nI could not find that service. What would you like today?"
      else  # If service is available
        ## Add customer if they do not exist in database
        # Get user's phone number
        echo -e "\nWhat is your phone number?"
        read CUSTOMER_PHONE
        CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")
        # If user not in database
        if [[ -z $CUSTOMER_NAME ]]
        then
            # Get new customer's name
            echo -e "\nWhat is your name?"
            read CUSTOMER_NAME
            # Insert new customer name and phone
            INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
        fi

        # Get customer id
        CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")

        # Promt user for SERVICE_TIME
        echo -e "\nAt what time do you want to schedule an appointment, $CUSTOMER_NAME?"
        read SERVICE_TIME

        # Insert appointment to the appintments table
        INSERT_APPOINTMENT_RESULT=$($PSQL "
            INSERT INTO appointments(customer_id, service_id, time) 
            VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')
        ")
        APPOINTMENT_INFO="I have put you down for a $SERVICE_CHOSEN at $SERVICE_TIME, $CUSTOMER_NAME."; 
        echo "${APPOINTMENT_INFO//  / }" # Parameter expansion. See https://www.shellcheck.net/wiki/SC2001. 
        # This is done instead of:
        # APPOINTMENT_INFO_FORMATTED=$(echo $APPOINTMENT_INFO | sed 's/ |/"/')
        # echo "$APPOINTMENT_INFO_FORMATTED"
      fi
    fi
}

# Display menu before the first prompt for input.
MAIN_MENU
