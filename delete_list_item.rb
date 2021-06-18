require_relative 'db'

# In this file, write code to delete an existing list item.
#
# The user will use this program from the command line as follows:
#
# $ ruby delete_list_item.rb shopping-list-id item-id
#
# where they provide the shopping list ID (database primary key) 
# as a command line argument to the program, and then the item's
# ID (primary key).
#  
# The code below grabs these arguments for you:

if ( ARGV.length != 2 )
  puts "usage:"
  puts
  puts "  ruby delete_list_item.rb shopping-list-id item-id"
  puts
  exit(1)
end

shoplist_id = ARGV[0].to_i
item_id = ARGV[1].to_i

# write code to delete the list item from the DB.
#
# If you cannot delete the list item, you should output an
# error msg: 

puts "Unable to delete shopping list item."

# If you succeed, output:

puts "Successfully deleted shopping list item." 

