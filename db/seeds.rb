User.create!(name:"rajeevr",email:"rajeevriitm@gmail.com",
                    password:"sadsad",password_confirmation:"sadsad",admin: true)
99.times do |n|
  name=Faker::Name.name
  email = "rajeev-#{n+1}@railstutorial.org"
  User.create!(name:name,email:email,password:"password",password_confirmation:"password")
end


# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
