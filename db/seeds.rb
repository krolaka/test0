require 'faker'

puts "Which email do you want use for loggin into site and adminstrate?"
email     = STDIN.gets.strip
password = '111111'

admin_user = User.create(:username => Faker::Internet.user_name,
                         :email => email, :password => password,
                         :password_confirmation => password,
                         :admin => true
                        )

if admin_user.valid?
  puts "Perfect! Your account was created with '111111' password."
else
  puts "Sorry but something went worng!"
  puts ""
  admin_user.errors.full_messages.each { |m| puts "   - #{m}" }
end


# Creates other users
blocked = false
i = 0
for i in 0..5
  email = Faker::Internet.safe_email
  blocked = true if i == 4
  user = User.create(:username => Faker::Internet.user_name,
                     :email => email,
                     :password => password,
                     :password_confirmation => password,
                     :blocked => blocked
                    )
  puts "User #{email} created with password '111111'" if user.valid?
end

puts "Generating disscussion."
# Creates messages
i = 0
r = 0
for i in 0..10
  first_random_user = User.order('RANDOM()').limit(1).first
  for i in 0..15
    users = User.order('RANDOM()').limit(5)
    if i == 0
      Message.create(rxuser_id: first_random_user.id,
                     txuser_id: users.last.id,
                     message: Faker::Lorem.sentence
                    )
    end
    users.each do |user|
      last_user_id = Message.last.rxuser_id
      Message.create(txuser_id: last_user_id,
                     rxuser_id: user.id,
                     message: Faker::Lorem.sentence
                    )
    end
  end
end
puts 'Done'
