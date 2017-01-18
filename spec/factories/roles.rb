FactoryGirl.define do
  factory :role do
    name { actor.male? ? FFaker::Name.male_name_with_prefix : FFaker::Name.female_name_with_prefix }
    movie
    actor
  end
end
