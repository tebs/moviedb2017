require 'rails_helper'

RSpec.describe Movie, type: :model do
  context "with valid attributes" do
    let(:movie) { build :movie }

    it "is valid" do
      expect(movie).to be_valid
    end
  end

  context "with missing title" do
    let(:movie) { build :movie, title: nil }

    it "is not valid" do
      expect(movie).to_not be_valid
    end
  end

  context "with another movie of the same name and year" do
  # another way to set the data
  # let(:movie) { build :movie }
  #
  # let(:another_movie) do
  #   create :movie, title: movie.title, year: movie.year
  # end

  before do
    FactoryGirl.create(:movie, title: "Star Wars", year: 1977)
  end

  it 'is not valid' do

    movie = build(:movie, title: "Star Wars", year: 1977)
    expect(movie).to_not be_valid
    # another way:
    # expect(movie.valid?).to be_falsey

    movie.year = 1978
    expect(movie).to be_valid
  end
end
end
