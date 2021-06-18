require_relative 'db'

# In this file, write code to create a new shopping list.
#
# Each shopping list has a name or description.
#
# The user will use this program from the command line as follows:
#
# $ ruby create_list.rb shopping-list-name
#
# where they provide the shopping list name as a command line argument to
# the program.
# 
# The code below grabs this argument for you:

if ( ARGV.length != 1 )
  puts "usage:"
  puts
  puts "  ruby create_list.rb shopping-list-name"
  puts
  exit(1)
end

shoplist_name = ARGV[0]

# write code to create the list in the DB

# If you fail to create the list (an error occurs), output:

puts "Unable to create shopping list."

# If you succeed in creating the list, output:

puts "Successfully created shopping list."


