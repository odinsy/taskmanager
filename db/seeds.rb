# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# @priorities = Priority.create([{priority: 0}, {priority: 1}, {priority: 2}, {priority: 3}])

4.times { |x| Priority.create(priority: x) }
