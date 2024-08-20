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

user = User.create!(
  email: "admin@admin.com",
  password: "adminadmin"
)

puts 'seeded user'

10.times do
  company = Company.create!(
    user: user,
    name: Faker::Company.name,
    address: Faker::Address.street_address,
    phone: Faker::PhoneNumber.phone_number,
    website: Faker::Internet.url,
    linkedin: Faker::Internet.domain_name
  )
end

puts 'seeded companies'

10.times do
  contact = Contact.create!(
    user: user,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    job_title: Faker::Job.title,
    phone: Faker::PhoneNumber.phone_number,
    email: Faker::Internet.email,
    address: Faker::Address.street_address,
    country: Faker::Address.country,
    birthday: Faker::Date.between(from: '1970-09-23', to: '2005-09-25'),
    archive: false,
    linkedin: Faker::Internet.domain_name,
    company: Company.all.sample
  )
end

puts 'seeded contacs'

10.times do
  event = Event.create!(
    user: user,
    name: Faker::Music::Opera.verdi,
    address: Faker::Address.street_address,
    company: Company.all.sample,
    start_date: Faker::Date.backward(days: (1..30).to_a.sample),
    end_date: Faker::Date.forward(days: (1..30).to_a.sample)
  )
end

puts 'seeded events'

10.times do
  notes = Note.create!(
    user: user,
    content: Faker::Coffee.notes,
    noteable: Company.all.sample,
    # contact: Contact.all.sample
  )
end

puts 'seeded notes'

10.times do
  todo = Todo.create!(
    user: user,
    name: Faker::Coffee.blend_name,
    end_date: Faker::Date.forward(days: (1..30).to_a.sample),
    todoable: Company.all.sample,
    # contact: Contact.all.sample,
    # event: Event.all.sample,
    status: Todo.statuses.keys.sample
  )
end

puts 'seeded todo'
puts 'seeding completed'
