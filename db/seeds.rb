# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


if Rails.env.development?
  # Create a bunch of genres
  puts "Creating genres..."
  FactoryGirl.create_list :genre, 10

  # Create a bunch of movies
  puts "Creating movies..."
  FactoryGirl.create_list :movie, 50
  50.times do
    FactoryGirl.create :movie,
        genre: Genre.order("RANDOM()").first
  end

  # Generate a bunch of actors
  puts "Creating actors..."
  FactoryGirl.create_list :actor, 50

  # Now assign random actors to random movies!
  puts "Creating roles..."
  #FactoryGirl.create_list :role, 200
  200.times do
    FactoryGirl.create :role,
        movie: Movie.order("RANDOM()").first,
        actor: Actor.order("RANDOM()").first
  end
end
