require_relative 'db'

# In this file, write code to create a new list item and 
# add it to an existing shopping list.
#
# The user will use this program from the command line as follows:
#
# $ ruby create_list_item.rb shopping-list-id item-description
#
# where they provide the shopping list ID (database primary key) 
# as a command line argument to the program, and then the new item's
# description.
#  
# The code below grabs these arguments for you:

if ( ARGV.length != 2 )
  puts "usage:"
  puts
  puts "  ruby create_list_item.rb shopping-list-id item-description"
  puts
  exit(1)
end

shoplist_id = ARGV[0].to_i
item_desc = ARGV[1]

# Write code to create the list item in the DB and add it to 
# the specified list.
#
# If you cannot create the list item, you should output an
# error msg: 

puts "Unable to create shopping list item."

# If you succeed, output:

puts "Successfully created shopping list item." 


