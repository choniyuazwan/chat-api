# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

[
    {username: 'budi', password: 'aaaaaa', fullname: 'budi handuk'},
    {username: 'tono', password: 'aaaaaa', fullname: 'tono sucipto'},
    {username: 'andi', password: 'aaaaaa', fullname: 'andi malarangeng'},
    {username: 'dodo', password: 'aaaaaa', fullname: 'dodo widodo'},
    {username: 'anto', password: 'aaaaaa', fullname: 'anto winaryo'},
    {username: 'sari', password: 'aaaaaa', fullname: 'sari awan'}
].each do |attributes|
  User.find_or_initialize_by(username: attributes[:username]).update!(attributes)
end