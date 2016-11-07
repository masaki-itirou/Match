# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

wd = ["a","b","c"]
ids = [*1..33]
#passwordはrをハッシュ化したもの
ids.each do |i|  
  User.create(name:"#{i}",
    password:"a882f0ac848b0b6b4ca7b42bfa1d266afd0ddeba9204ae57a984a69376d59816b1ef3f4d442ea8a70396067ff5b70e0ae8eab3935b617b8e366d8e35c3bfe14c",
    word:wd.join(" ")
   )  
end

wd.each do |w|
  Point.create(word:w,user_id:ids.join(" "))
end   
