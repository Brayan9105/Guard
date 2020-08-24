# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
User.create!(email: 'test@mail.com', password: '123456')

(1..100).each do |x|
	Token.create!(name: "Ficha ${x}")
end

UserCategory.created!(name: 'Visitante')
UserCategory.created!(name: 'Proveedor')
UserCategory.created!(name: 'Funcionario')

Health.create!(name: 'Sin especificar', address: 'NN', phone: 'NN')
Health.create!(name: 'sura', address: 'cra 70 #80-3', phone: '1234567')

Security.create!(name: 'Sin especificar', address: 'NN', phone: 'NN')
Security.create!(name: 'positiva', address: 'cra 70 #80-3', phone: '1234567')