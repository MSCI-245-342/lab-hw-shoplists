require_relative 'db'

# In this file, write code to delete an existing list item.
#
# The user will use this program from the command line as follows:
#
# $ ruby delete_item.rb item-id
#
# where they provide the shopping list item's ID (database primary key).
#  
# The code below grabs this argument for you:

if ( ARGV.length != 1 )
  puts "usage:"
  puts
  puts "  ruby delete_item.rb item-id"
  puts
  exit(1)
end

item_id = ARGV[0].to_i

# write code to delete the list item from the DB.
#
# If you cannot delete the list item, you should output an
# error msg: 

puts "Unable to delete shopping list item."

# If you succeed, output:

puts "Successfully deleted shopping list item." 

