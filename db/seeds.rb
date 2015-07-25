User.create!(name:"Rajeev.R",email:"rajeevriitm@gmail.com",
  password:"sadsad",password_confirmation:"sadsad",admin: true,activated:true,activated_at:Time.zone.now)
99.times do |n|
  name=Faker::Name.name
  email = "Rajeev-#{n+1}@railstutorial.org"
  User.create!(name:name,email:email,password:"password",password_confirmation:"password",
    activated:true,activated_at:Time.zone.now)
end

#adding followers and followeds
users=User.all
user=users.first
following=users[2..50]
followers=users[3..40]
following.each {|followed| user.follow(followed)}
followers.each {|follower| follower.follow(user)}


#creating microposts
users=User.order(:created_at).take(6)
50.times do
  content=Faker::Lorem.paragraph(sentence_count= 2)
  users.each do |user|
    user.microposts.create!(content: content)
  end
end

#creating answers
microposts=Micropost.order(:created_at).take(20)
users=User.order(:created_at).take(5)
3.times do
  users.each { |user|
    content=Faker::Lorem.paragraph(sentence_count=15)
    microposts.each {|micropost|
      user.answers.create!(response: content,micropost_id: micropost.id)
    }
  }
end

