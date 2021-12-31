# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Message.destroy_all
Conversation.destroy_all
User.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('messages')
ActiveRecord::Base.connection.reset_pk_sequence!('conversations')
ActiveRecord::Base.connection.reset_pk_sequence!('users')

[
    {username: 'budi', password: 'aaaaaa', fullname: 'budi handuk'},
    {username: 'tono', password: 'aaaaaa', fullname: 'tono sucipto'},
    {username: 'andi', password: 'aaaaaa', fullname: 'andi malarangeng'},
    {username: 'dodo', password: 'aaaaaa', fullname: 'dodo widodo'},
    {username: 'anto', password: 'aaaaaa', fullname: 'anto winaryo'},
    {username: 'sari', password: 'aaaaaa', fullname: 'sari awan'}
].each do |attributes|
  User.create(attributes)
end