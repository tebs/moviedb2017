FactoryGirl.define do
  factory :genre do
    # this will create duplicates and violate the genre validation on the name
    # name "MyString"

    # although less probable, this will create collisions too
    # name { FFaker::Book.genre }

    # same with this one
    # name { "Genre #{rand(1..100000000)}" }

    # with this option we make sure the genre name is unique
    sequence(:name) { |i| "Genre #{i}" }
  end
end
