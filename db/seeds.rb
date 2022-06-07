# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

user = User.create(
  email: 'jerko.culina@example.com', 
  password: 'thisisvalidpassword', 
  password_confirmation: 'thisisvalidpassword', 
  available_cents: 1000_00,
  auth_token: 'b74dCaZwiEUmV0kE03tvksECtfmDq3xMU856FCAVWRJ5GABWbOSMy5FHw6yy'
)

category_1 = Category.create(
  user: user,
  name: 'Rezije'
)

category_2 = Category.create(
  user: user,
  name: 'Zabava'
)

category_1_expenses = Expense.create(
  category: category_1,
  amount_cents: 100_00,
  title: "Struja"
)

category_2_expenses = Expense.create(
  category: category_2,
  amount_cents: 50_00,
  title: "Kino"
)