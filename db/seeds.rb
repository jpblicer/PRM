# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts 'clearing all databases'

Note.destroy_all
Event.destroy_all
Todo.destroy_all
Contact.destroy_all
Company.destroy_all
User.destroy_all


# db/seeds.rb

require 'faker'

# Create Users
user = User.create!(
    email: "admin@admin.com",
    password: "adminadmin"
  )

# Create Companies
companies = 5.times.map do
  Company.create!(
    name: Faker::Company.name,
    address: Faker::Address.full_address,
    phone: Faker::PhoneNumber.phone_number,
    website: Faker::Internet.url,
    # archive: Faker::Boolean.boolean,
    linkedin: Faker::Internet.url(host: 'linkedin.com'),
    user: user,
    # avatar: Faker::Avatar.image
  )
end

# Create Contacts
contacts = 10.times.map do
  Contact.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    job_title: Faker::Job.title,
    phone: Faker::PhoneNumber.phone_number,
    address: Faker::Address.full_address,
    birthday: Faker::Date.birthday(min_age: 18, max_age: 65),
    archive: Faker::Boolean.boolean,
    linkedin: Faker::Internet.url(host: 'linkedin.com'),
    company_id: companies.sample.id,
    user: user,
    email: Faker::Internet.unique.email,
    country: Faker::Address.country,
    avatar: Faker::LoremFlickr.unique.image
  )
end

# Create Events
events = 5.times.map do
  Event.create!(
    name: Faker::Music::Opera.verdi,
    address: Faker::Address.full_address,
    company_id: companies.sample.id,
    start_date: Faker::Date.forward(days: 30),
    end_date: Faker::Date.forward(days: 60),
    user: user
  )
end

# Create Notes
notes = 10.times.map do
  Note.create!(
    content: Faker::Lorem.paragraph,
    noteable_id: rand(1..100), # Replace with actual noteable IDs if needed
    noteable_type: ['Contact', 'Event'].sample,
    user: user
  )
end

# Create Todos
todos = 10.times.map do
  Todo.create!(
    name: Faker::Lorem.sentence(word_count: 3),
    end_date: Faker::Date.forward(days: 14),
    status: Todo.statuses.keys.sample,
    todoable_id: rand(1..100), # Replace with actual todoable IDs if needed
    todoable_type: ['Contact', 'Event'].sample,
    user: user
  )
end

# Create PgSearch Documents (if you're using the pg_search gem)
# pg_search_documents = (contacts + events).each do |searchable|
#   PgSearchDocument.create!(
#     content: searchable.to_s,
#     searchable_type: searchable.class.name,
#     searchable_id: searchable.id
#   )
# end



# user = User.create!(
#   email: "admin@admin.com",
#   password: "adminadmin"
# )

# puts 'seeded user'

# 10.times do
#   Company.create!(
#     user: user,
#     name: Faker::Company.name,
#     address: Faker::Address.street_address,
#     phone: Faker::PhoneNumber.phone_number,
#     website: Faker::Internet.url,
#     linkedin: Faker::Internet.domain_name,
#     avatar: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9eKVfG9-n89X7vmzotbHPnnLqdIJNdrGv8XQTRTnzFBPT3rAFNGy6ImFE9FoNM1_3MfI&usqp=CAU"
#   )
# end

# puts 'seeded companies'

# 10.times do
#   Contact.create!(
#     user: user,
#     first_name: Faker::Name.first_name,
#     last_name: Faker::Name.last_name,
#     job_title: Faker::Job.title,
#     phone: Faker::PhoneNumber.phone_number,
#     email: Faker::Internet.email,
#     address: Faker::Address.street_address,
#     country: Faker::Address.country,
#     birthday: Faker::Date.between(from: '1970-09-23', to: '2005-09-25'),
#     archive: false,
#     linkedin: Faker::Internet.domain_name,
#     company: Company.order("RANDOM()").limit(1).first,
#     avatar: "https://media.licdn.com/dms/image/v2/C5603AQGFsq4Z2sjOzA/profile-displayphoto-shrink_400_400/profile-displayphoto-shrink_400_400/0/1638927273157?e=1729728000&v=beta&t=2y7V9w5wGzydguJucApw8p4gjiUXgROUgPmN2tiM62Y",
#     # company: Company.all.sample
#   )
# end

# puts 'seeded contacs'

# 10.times do
#   Event.create!(
#     user: user,
#     name: Faker::Music::Opera.verdi,
#     address: Faker::Address.street_address,
#     company: Company.order("RANDOM()").limit(1).first,
#     # company: Company.all.sample,
#     start_date: Faker::Date.backward(days: (1..30).to_a.sample),
#     end_date: Faker::Date.forward(days: (1..30).to_a.sample)
#   )
# end

# puts 'seeded events'

# 10.times do
#   Note.create!(
#     user: user,
#     content: Faker::Coffee.notes,
#     noteable: Company.order("RANDOM()").limit(1).first
#     # noteable: Contact.all.sample
#   )
# end

# 10.times do
#   Note.create!(
#     user: user,
#     content: Faker::Coffee.notes,
#     noteable: Contact.order("RANDOM()").limit(1).first
#   )
# end

# puts 'seeded notes'

# todos = 10.times.map do
#   Todo.create!(
#     user: user,
#     name: Faker::Coffee.blend_name,
#     end_date: Faker::Date.forward(days: 30),
#     status: Todo.statuses.keys.sample,
#     todoable: Contact.order("RANDOM()").limit(1).first
#   )
# end

# todos = 10.times.map do
#   Todo.create!(
#     user: user,
#     name: Faker::Coffee.blend_name,
#     end_date: Faker::Date.forward(days: 30),
#     status: Todo.statuses.keys.sample,
#     todoable: Company.order("RANDOM()").limit(1).first
#   )
# end

# todos = 10.times.map do
#   Todo.create!(
#     user: user,
#     name: Faker::Coffee.blend_name,
#     end_date: Faker::Date.forward(days: 30),
#     status: Todo.statuses.keys.sample,
#     todoable: Event.order("RANDOM()").limit(1).first
#   )
# end

# puts 'seeded todo'
# puts 'seeding completed'
