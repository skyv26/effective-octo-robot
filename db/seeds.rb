# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb

require 'faker'

blood_groups = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-']
genders = ['Male', 'Female', 'Other']

50.times do
  Patient.create!(
    name: Faker::Name.name,
    age: rand(1..90),
    gender: genders.sample,
    phone: Faker::PhoneNumber.cell_phone_in_e164, # This gives a +1234567890 format
    email: Faker::Internet.unique.email,
    blood_group: blood_groups.sample,
    address: Faker::Address.full_address,
    medical_history: Faker::Lorem.paragraph(sentence_count: 3),
    allergies: Faker::Lorem.words(number: 3).join(', '),
    emergency_contact: Faker::PhoneNumber.phone_number,
    avatar_url: Faker::Avatar.image(slug: Faker::Internet.slug, size: "100x100", format: "png", set: "set2")
  )
end
