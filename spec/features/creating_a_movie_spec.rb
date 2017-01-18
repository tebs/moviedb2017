require 'rails_helper'

feature "creating a movie" do
  # by using let you can remove the instance variables.
  # let! makes sure a before block is created so data is ready before the test starts
  # let!(:genre) { create :genre}
  # let!(:movie) { build :movie}

  before do
    @genre = create :genre
    @movie = build :movie
  end

  specify do
    visit '/'
    click_on 'New Movie'

    expect(page).to have_css 'h1', text: 'New Movie'

    fill_in "Title", with: @movie.title
    fill_in "Year", with: @movie.year
    fill_in "Description", with: @movie.description

    # you can also do:
    # select @genre.name, from: "Genre"
    find(:select, "movie_genre_id").find(:option, @genre.name).select_option

    click_button "Create Movie"

    expect(page).to have_css 'h1', text: "#{@movie.title} (#{@movie.year})"
  end
end
