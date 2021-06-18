# Lab and HW - Shopping Lists

This week, lab and home are combined.  In lab, you will work with your team to design a database via ERD and write the SQL code needed to create the tables.

In the homework, you will continue the development to create a shopping list app that uses your database.  If you don't finish the lab, or decide to change your design, that is ok.  Use the lab as a time to help each other get started with this homework and overcome the hurdle of going from a description of an app to a database design that supports the app.

# Shopping List App

You are going to create an app to keep track of your own personal shopping lists.  As the user of your app, you want it to enable you to:

+ Be able to create a new shopping list.  Each shopping list has a name (string).

+ Be able to view a list of all shopping lists.

+ Be able to select a shopping list from the list of shopping lists and view the shopping list.

+ Be able to select a shopping list and delete it and all the items on it.

+ For an individual shopping list, you want to be able to add shopping list items to the list.  Each shopping list item consists of a single string description.

+ For an individual shopping list, you want to be able to select and delete an existing item on the list.

Of note, your app is very simple, and does not give you the ability to edit the name of a shopping list.  In addition, your app doesn't let you edit the items on the shopping list. You can add and delete the items, but not edit them.  Finally, there is no functionality to allow you to order the items on your list.  They show up in whatever order (the order is "unspecified").

# Lab

Work with your team to come up with an Entity-Relationship diagram for a database that will allow you to store your app's data in it.

You will turn in the work you've completed at the end of the lab by committing it to GitHub.  The lab is participation marked, which means if it appears you attended lab and made reasonable progress during the lab time, you will get full credit for the lab.

For your entity sets:

+ Use a plural name.  For example, if we were designing a database for books, we'd have a *books* relation and not a *book* relation.

+ Use [synthetic, surrogate primary keys](https://en.wikipedia.org/wiki/Surrogate_key) named `id` that are integers auto-incremented by the database on insert. You may have other candidate keys for your entity sets, but having a single attribute, surrogate primary key named `id` matches the convention Rails uses, and is a nice pattern to follow.  Later in the lab, we show how to make a table with an auto-incremented primary key in Postgresql.

Create the ER diagram.  On the diagram, write out what the diagram's schema will be using the simple format the book uses.  For example, for a relation named users, we might write: _users_ ( <u>id</u>, name ).

Then export/save/scan your ERD and schema to PDF format.  Name the diagram "ERD-schema.pdf".  Upload the PDF to Codio and commit it to your repository.  

## Creating a new postgresql database

We need to do some special work to create a new postgresql database.  We are going to name our database `shoplists`.

From the terminal:

```
sudo su postgres
psql
```
Then from within psql (don't forget the semi-colon):
```
CREATE DATABASE shoplists ;
\q
```
Then at the shell prompt:
```
exit
```
To exit the shell and get back to being user `codio`.  Verify you are `codio` with `whoami`.  

You should be able to verify that `shoplists` exists by doing:
```
psql -d shoplists
````
If you check, you shouldn't see tables in it yet.

## From schema to SQL

You've made a simple description of your schema in your ERD-schema.pdf file. Now you need to translate that into SQL commands that can be used to create your tables and fill them with development data.  It is very handy to have data in our database while we develop it.

You are going to make one file named `create-tables.sql` and one file named `drop-tables.sql` and one named `dev-data.sql`.  The easy way to make blank files in the terminal is with touch:
```
touch create-tables.sql
touch drop-tables.sql
touch dev-data.sql
```
You will now have two empty files waiting for you to edit.  You may edit them with the Codio IDE or using nano.

In both files, you are going to write SQL statements.  Remember that each SQL statement should end with a semi-colon.

In the `create-table.sql` file, you want to write the SQL CREATE statements that will create your tables.  The [Postgresql documentation for CREATE](https://www.postgresql.org/docs/current/sql-createtable.html) is a bit overwhelming at first, but with some effort, you can figure it out.  There is also all of the [Postgresql datatypes](https://www.postgresql.org/docs/13/datatype.html).

The Database System Concepts (DSC) textbook shows the syntax of create table statements in section 3.2.  It is easier to read than the Postgresql documentation, but not as complete.

It can be even easier to see some simple examples.  Here is a simple table to create a `books` table that has an auto-incremented primary key named id and a title that is not allowed to be null:

```sql
CREATE TABLE books ( 
  id	SERIAL PRIMARY KEY,
  title	TEXT NOT NULL
);
```
The type `SERIAL` is specific to Postgresql.  It will create an auto-incremented integer sequence.  We then identify this attribute as a `PRIMARY KEY`.  

The `TEXT` type is also special to Postgresql.  It allows strings of any length.  We specify that `title` should not be allowed to be `NULL`.

Now, let's say there is also an authors table:
```sql
CREATE TABLE authors ( 
  id	SERIAL PRIMARY KEY,
  name	TEXT NOT NULL
);
```
And that we have a relationship of many-to-many between them:
```sql
CREATE TABLE author_book ( 
  author_id INTEGER NOT NULL,
  book_id	INTEGER NOT NULL
);
```
This is all well and good, but we don't have any foreign key restrictions on the `author_book` relationship set.  So, looking at the docs, we see that we really need to define it as:
```sql
CREATE TABLE author_book ( 
  author_id INTEGER NOT NULL REFERENCES authors ( id ),
  book_id   INTEGER NOT NULL REFERENCES books ( id )
);
```
We also need a primary key, and since it is many-to-many, both `author_id` and `book_id` form the primary key. 
```sql
CREATE TABLE author_book ( 
  author_id INTEGER NOT NULL REFERENCES authors ( id ),
  book_id   INTEGER NOT NULL REFERENCES books ( id ),
  PRIMARY KEY ( author_id, book_id ) 
);
```
You can run your `create-tables.sql` script by doing:
```
psql -d shoplists
```
and then from within psql:
```
\i create-tables.sql
```
which will read your file and run the commands in it for you.

You should definitely inspect your tables from within psql.  If you had the books, authors, and author_book tables you'd do:
```
\d 
\d books
\d authors
\d author_book
```
to see that you have everything defined as expected.

You will make mistakes in creating your database.  If not today, then someday.  You'll want an easy way to reset it and get rid of all those mistakenly made tables.  To do this, in your `drop-tables.sql` file, create a DROP TABLES statement for each table in your database.  For example:

```sql
DROP TABLE author_book ;
DROP TABLE books ;
DROP TABLE authors ;
```
Note that we'll want to drop tables in an order such that we don't violate any integrity constraints or else the command might fail.  You can run this script in psql with `\i drop-tables.sql`.

Write the `create-tables.sql` and `drop-tables.sql` code for your database, run them, and commit them to your repo.

Now that you have your schema made, you should create some insert statements in your `dev-data.sql` to add data to your tables.  Create the following data.

+ One list named "groceries", one list named "tools", and one named "misc".

+ In the groceries list, add: milk, bananas, and cookies.

+ In the tools list add: screwdriver.

+ In the misc list add nothing (leave it empty).

We these lists, you can better see if your app works as you expect it to.

### More details about dev-data.sql

With the auto-incremented ids for your entities, it can be hard to understand how to create dev-data.sql.  

First, you'll want to be sure you're starting from a completely fresh database prior to inserting data.  We want our ids to start incrementing from 1.

To be sure you have a fresh database, drop the tables and create them anew.

You are going to write a series of INSERT statements.  One statement per row you are inserting.

To be sure that you know the ID of the row you are inserting, actually supply the ID in the insert.  Even though you have an auto-incrementing ID, you are still allowed to "force" a specific value for this attribute.

The [bookratings DB load data script](https://github.com/MSCI-245-342/bookratings-db/blob/master/sql/insert-rails-style-no-zero-ratings.sql) shows an example of this technique.  The script inserts books and specifies their ID, even though the books table has ID as an auto-incremented primary key.

The downside with this is that the DB doesn't know you've been inserting data and sidestepping the auto-increment functionality.  Thus, if you insert more data, it will attempt to start at ID=1, and this will be an error.  Thus, you need to advance the sequence past your last inserted ID.

For the books DB, the last ID inserted is 55.  After that is done, we run this SQL statement to move the auto-increment sequence to start back up at past this value:
```sql
ALTER SEQUENCE books_id_seq RESTART 56 ;
```
The `books_id_seq` can be found by looking at the table `books` in psql with `\d books`:
```
bookratings=# \d books
                                    Table "public.books"
 Column |          Type          | Collation | Nullable |              Default              
--------+------------------------+-----------+----------+-----------------------------------
 id     | integer                |           | not null | nextval('books_id_seq'::regclass)
 title  | character varying(255) |           | not null | 
 author | character varying(50)  |           | not null | 
Indexes:
    "books_pkey" PRIMARY KEY, btree (id)
Check constraints:
    "books_author_check" CHECK (author::text <> ''::text)
    "books_title_check" CHECK (title::text <> ''::text)
Referenced by:
    TABLE "ratings" CONSTRAINT "ratings_book_id_fkey" FOREIGN KEY (book_id) REFERENCES books(id)
```  
For the id column, you can see that is has a "Default" of "nextval('books_id_seq'::regclass)", which shows the name of the sequence: "books_id_seq".

Because you know the ids of the rows you are inserting into tables, you can then easily refer to them in other insert statements.  

### Once you have your dev-data.sql ready

Run your `dev-data.sql` script in psql:
```
\i dev-data.sql
```
and verify that it inserts the data for you.  If you make any mistakes, reset your database by dropping the tables with your `drop-tables.sql` script.

At the end of lab, be sure to push everything you have done to github.  We will look at your github repo to see what you did in lab.

If you have time remaining, you are welcome to start the homework and continue to cooperatively solve it with your team.  Once lab is over, you should no longer work with your team on the homework and only work on it yourself within the rules established in the instructions in Learn.

# Homework

In addition to this programming assignment, there may be a Crowdmark portion for you to complete. Please see the instructions in Learn.

For the programming portion of the homework, implement your shopping list app using Ruby and the [Sequel](http://sequel.jeremyevans.net/) gem. You'll need to create a `Gemfile` with the following content:
```ruby
source 'https://rubygems.org'

gem 'sequel'
gem 'pg'
```
and then run `bundle install`.  Be sure to commit the Gemfile and the Gemfile.lock files to your repo.

Rather than build a standard interactive program with prompts, we will interact with our app via a series of ruby progams that allow us to view, create, and delete items from our database.  

You will find the following ruby files for our app:

1. get_lists.rb
2. get_list_items.rb
3. create_list.rb
4. create_list_item.rb
5. delete_list_item.rb
6. delete_list.rb

In each file, it gives directions on what to do.  It is easiest to work on them on the order above.  

The user interface is crude, and it requires us to use internal database IDs, but it mimics how we'll build web apps.  This organization of functionality is akin to what we would provide as an "application programming interface" ([API](https://en.wikipedia.org/wiki/API)).  

You could imagine another program calling our programs as part of a program that provides a nice user interface to database.  Indeed, we could write many different apps that all use these programs as a standard interface to interact with our database while not needing to know how we implemented this functionality in the database.  We have created an abstraction layer to hide our database and the SQL calls.

## Detecting failed INSERTs and DELETEs 

When you do a DELETE, Sequel will return the number of rows deleted. For example, if there are 6 books with the title = 'Mark', then this code will print out the number 6:
```ruby
delete_books = DB["delete from books where title = 'Mark'"]
p delete_books.delete
```
Thus, based on the number of rows reported deleted, you can know if your delete was successful or not.

For INSERT, matters are more complex.  In general, you can assume the INSERT succeeded unless an exception is raised.  Thus, to know that an INSERT failed, you need to wrap the INSERT with a `begin` `rescue` `end`.  This [post](https://www.honeybadger.io/blog/a-beginner-s-guide-to-exceptions-in-ruby/) is helpful, as would any other Ruby book.

In general, all of your database calls with Sequel, should be wrapped with a `begin` `rescue` `end` to catch possible exceptions and know there was a failure.  This includes DELETE.

## Turning in your work

Once done, be sure to commit and push it to GitHub.  You can, of course, commit and push to GitHub frequently as a way to back up your work.  You do not have to wait till the very end to do your first commit and push.


