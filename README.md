PLSQL projects used to solve some business issues:

1- first project is used to create sequences and trigger for each table in the schema.
  - the sequence should start from the maximum number in the primary key column +1.
  - the sequence would only be created if the the table have one primary key column and it has (int) data type.
  - trigger is made to add the next value of the primary key column sequence when inserting a new record. so the user don't have to insert the primary key column value.

2- Second project is used to import the new employees records in a temporary table.
  - checking the integrity of the data.
  - checking the departments, city and regions occurance in the parent tables, and if not insert them first.
  - lastely import the data from the temporary table to the main empolyees table.
