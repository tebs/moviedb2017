require 'rails_helper'

RSpec.describe Movie, type: :model do
  before do
    stub_request(:get, /www.omdbapi.com/).
        to_return(status: 200, body: '{"Poster":"https://images-na.ssl-images-amazon.com/images/M/MV5BMTQ1MjQwMTE5OF5BMl5BanBnXkFtZTgwNjk3MTcyMDE@._V1_SX300.jpg"}', headers: {"Content-Type" => "application/json"})
  end

  context "with valid attributes" do
    let(:movie) { build :movie }

    it "is valid" do
      expect(movie).to be_valid
    end

    it "fetches the movie poster" do
      movie.save

      expect(movie.poster_url).not_to be_empty
      expect(movie.poster_url).to eq("https://images-na.ssl-images-amazon.com/images/M/MV5BMTQ1MjQwMTE5OF5BMl5BanBnXkFtZTgwNjk3MTcyMDE@._V1_SX300.jpg")
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
