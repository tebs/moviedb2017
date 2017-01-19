class Movie < ApplicationRecord
  validates :title,
    presence: true,
    uniqueness: { scope: :year }

  validates :year,
    presence: true,
    numericality: true

  # not needed in rails 5 since belongs_to already does it by default
  validates :genre_id,
    presence: true

  scope :alphabetically, -> { order(:title) }

  has_many :roles,
    dependent: :destroy

  has_many :actors,
    through: :roles

  # in rails 5 add  "optional: true" if you want genre to be optional
  belongs_to :genre

  before_save :get_poster

  # Renders the full title of the movie, which is a concatenation
  # of its title and year (eg. "Star Wars (1977)")
  #
  # Note: we're using `title_was` and `year_was` instead of `title`
  # and `year` so we're still displaying the original data while the
  # record is being edited.
  #
  def full_title
    "#{title_was} (#{year_was})"
  end

  # Overriding `to_param` is a cheap way to get the movie's title into
  # its URL without having to store slugs in the database.
  #
  def to_param
    "#{id}-#{title.parameterize}"
  end

  def get_poster
    if title_changed? || year_changed?
      self.poster_url = ::PosterFetcher.get(self)
    end
  end
end
