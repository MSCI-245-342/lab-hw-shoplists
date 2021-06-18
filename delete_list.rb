
require_relative 'db'

# In this file, write code to delete an existing shopping list.
#
# The user will use this program from the command line as follows:
#
# $ ruby delete_list.rb shopping-list-id
#
# where they provide the shopping list ID (database primary key) 
# as a command line argument to the program.
#  
# The code below grabs this argument for you:

if ( ARGV.length != 1 )
  puts "usage:"
  puts
  puts "  ruby delete_list.rb shopping-list-id"
  puts
  exit(1)
end

shoplist_id = ARGV[0].to_i

# write code to delete the list from the DB.
#
# If you cannot delete the list, you should output an
# error msg: 

puts "Unable to delete shopping list."

# If you succeed, output:

puts "Successfully deleted shopping list." 



