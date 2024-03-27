#! /bin/bash
# This script is used to fix the starting database to meet all 
# the requirements in the instructions 

# # Connect to "periodic_table" database
PSQL="psql --username=freecodecamp --dbname=periodic_table -c"
echo -e "\n\n---- Logged in ----"

# # --- RENAME COLUMNS IN properties TABLE
# echo -e "\nRENAME COLUMNS"
# # `weight` to `atomic_mass`.
# $PSQL "ALTER TABLE properties RENAME COLUMN weight TO atomic_mass;"
# # `melting_point` to `melting_point_celsius`
# $PSQL "ALTER TABLE properties RENAME COLUMN melting_point TO melting_point_celsius"
# # `boiling_point` to `boiling_point_celsius`
# $PSQL "ALTER TABLE properties RENAME COLUMN boiling_point TO boiling_point_celsius"

# echo -e "\n--- SET NOT NULL CONSTRAINTS ---"
# # Set NOT NULL constraint to "melting_point_celsius" and "boiling_point_celsius" in "properties".
# $PSQL "
#     ALTER TABLE properties 
#         ALTER COLUMN melting_point_celsius SET NOT NULL,
#         ALTER COLUMN boiling_point_celsius SET NOT NULL
# "

# echo -e "\n--- SET NOT NULL AND UNIQUE CONSTRAINTS ---"
# # Add NOT NULL and UNIQUE constraint to "name" and "symbol" in "elements".
# $PSQL "
#     ALTER TABLE elements 
#         ALTER COLUMN symbol SET NOT NULL,
#         ALTER COLUMN name SET NOT NULL,
#         ADD UNIQUE(symbol),
#         ADD UNIQUE (name)
# "

# echo -e "\n--- CREATE TABLE 'types' and INSERT 3 rows ---"
# # Create table "types"
# $PSQL "
#     CREATE TABLE types(
#         type_id SERIAL PRIMARY KEY,
#         type VARCHAR NOT NULL
#     )
# "
# # Insert rows into "types"
# $PSQL "
#     INSERT INTO types(type)
#     VALUES('metal'),
#         ('nonmetal'),
#         ('metalloid')
# "

# # Add FOREIGN KEY column in the "properties"-table: "type_id" referencing "type_id" in "types". 
# $PSQL "ALTER TABLE properties ADD COLUMN type_id INT REFERENCES types(type_id);"
# $PSQL "ALTER TABLE properties ADD FOREIGN KEY(atomic_number) REFERENCES elements(atomic_number);"


# # Update "type_id" in the "properties" table, with values from "type_id" in the "types" table.
# $PSQL "
#     UPDATE properties p
#     SET type_id = t.type_id
#     FROM types t
#     WHERE t.type = p.type
# " # Thanks to https://stackoverflow.com/a/2766766/19325760 (update-fields-of-one-table-from-fields-of-another-one)

# # Set the "type_id" in "properties" table to NOT NULL.
# $PSQL "ALTER TABLE properties ALTER COLUMN type_id SET NOT NULL"


# # Capitalize the first letter of all "symbol" values in the "elements" table.
# # Only change the first letter.
# echo -e "\n--- UPDATE ELEMENTS UPPER FIRST CASE ---"
# $PSQL "
# UPDATE elements
#     SET symbol = CONCAT(
#                     UPPER(LEFT(symbol,1)),
#                     SUBSTRING(symbol,2,LENGTH(symbol)) 
#                 )
# "


# # Remove all trailing zeros after the decimals from each row in `atomic_mass` (in "properties"). The final values they should be are in the `atomic_mass.txt` file
# echo -e "\nAlter type of atomic_mass from 'numeric(precision, scale)' to onlye 'numeric'. Then trim_scale(atomic_mass)"
# $PSQL "ALTER TABLE properties ALTER COLUMN atomic_mass TYPE decimal;"
# $PSQL "UPDATE properties SET atomic_mass = trim(TRAILING '0' FROM CAST(atomic_mass AS TEXT))::DECIMAL;"
# # Thanks to https://stackoverflow.com/a/73165542/19325760

# # # Add the element with atomic number=9 to your database. name=Fluorine, symbol=F, mass=18.998, melting point=-220, boiling point=-188.1, and type=nonmetal.
# $PSQL "
# INSERT 
#     INTO elements(  atomic_number,  symbol,     name)
#     VALUES(         9,              'F',        'Fluorine')
# ;"
# $PSQL "
# INSERT 
#     INTO properties(
#         atomic_number, type, atomic_mass, 
#         melting_point_celsius, boiling_point_celsius, type_id)
#     VALUES(
#         9, 'nonmetal', 18.998,
#         -220, -188.1, 2)
# ;"


# # Add the element with atomic number `10` to your database. 
# # Its name is `Neon`, symbol is `Ne`, mass is `20.18`, melting point is 
# # `-248.6`, boiling point is `-246.1`, and it's a `nonmetal`
# $PSQL "
# INSERT 
#     INTO elements(  atomic_number,  symbol,     name)
#     VALUES(         10,              'Ne',        'Neon')
# ;"
# $PSQL "
# INSERT 
#     INTO properties(
#         atomic_number, type, atomic_mass, 
#         melting_point_celsius, boiling_point_celsius, type_id)
#     VALUES(
#         10, 'nonmetal', 20.18, 
#         -248.6, -246.1, 2)
# ;"

# # Delete the non existent element, whose `atomic_number` is `1000`, from the two tables
# $PSQL "DELETE FROM properties WHERE atomic_number=1000;"
# $PSQL "DELETE FROM elements WHERE atomic_number=1000;"

# # Your properties table should not have a type column
# $PSQL "ALTER TABLE properties DROP COLUMN type;"
