require_relative 'db'

# In this file, write code to display the items on a shopping list.
#
# The user will use this program from the command line as follows:
#
# $ ruby get_list_items.rb shopping-list-id
#
# where they provide the shopping list ID (database primary key) 
# as a command line argument to the program.
#  
# The code below grabs this argument for you:

if ( ARGV.length != 1 )
  puts "usage:"
  puts
  puts "  ruby get_list_items.rb shopping-list-id"
  puts
  exit(1)
end

shoplist_id = ARGV[0].to_i

# write code to fetch all list items in the DB.  You
# should output the item's ID (primary key) and its name/description.
#
# For example, a list with milk, bananas, and cookies may output as:
#
# 4 milk
# 8 bananas
# 13 cookies
#
# The IDs can, of course, differ.

