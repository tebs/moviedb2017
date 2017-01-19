class PosterFetcher

  def self.get(movie)
    uri = sprintf("http://www.omdbapi.com/?t=%s&y=%i&plot=short&r=json", movie.title, movie.year)

    response = HTTParty.get(uri)
    response.parsed_response['Poster']
  end
end
