# Erase the content of all tables, hence reseting the related "id" counters
DatabaseCleaner.clean_with(:truncation)

p ' ########################'
p '## Generation des users ##'
p ' ########################'

User.create!(email: "admin@yopmail.com", password: 'EcoDevIT@2022', username: Faker::Internet.username(specifier: 5..8), role: 2)
p "L'utilisateur #{User.last.username.capitalize} vient d'être généré."
p "Son adresse email est #{User.last.email}."
p "Son role est #{User.last.role}."
puts "\n"

3.times do |i|
  User.create!(email: "instructor#{i+1}@yopmail.com", password: 'EcoDevIT@2022', username: Faker::Internet.username(specifier: 5..8), role: 1)
    p "L'utilisateur #{User.last.username.capitalize} vient d'être généré."
    p "Son adresse email est #{User.last.email}."
    p "Son role est #{User.last.role}."
    puts "\n"  
end

3.times do |i|
  User.create!(email: "student#{i+1}@yopmail.com", password: 'EcoDevIT@2022', username: Faker::Internet.username(specifier: 5..8))
  p "L'utilisateur #{User.last.username.capitalize} vient d'être généré."
  p "Son adresse email est #{User.last.email}."
  p "Son role est #{User.last.role}."
  puts "\n" 
end