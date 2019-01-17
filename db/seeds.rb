# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#

User.create!(email: "admin@gmail.com", password: '123456', full_name: "admin", password_confirmation: "123456")
User.create!(email: "shiv@gmail.com", password: '123456', full_name: "shiv", password_confirmation: "123456")

user = User.find_by( email: 'admin@gmail.com')
user.confirmed_at = Time.now
user.save!

UserRole.create!(user_id: user.id, role_id: 0)
