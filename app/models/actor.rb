class Actor < ApplicationRecord
  validates :first_name, :last_name,
    presence: true

  validates :gender,
    presence: true,
    inclusion: { in: ['m', 'f'], allow_blank: true }

  # Add a custom validation to check that birthdate is not
  # in the future.
  #
  validate do
    if birthdate.present? && birthdate >= Date.today
      errors.add(:birthdate, "can't be in the future")
    end
  end

  scope :with_birthdays,
    -> { with_birthdays_on(Date.today) }

  scope :with_birthdays_on,
    ->(date) { where("strftime('%d-%m', birthdate) = ?", date.strftime("%d-%m")) }

  has_many :roles,
    dependent: :destroy

  has_many :movies,
    through: :toles


  def full_name
    "#{first_name_was} #{last_name_was}"
  end

  def to_param
    "#{id}-#{full_name.parameterize}"
  end

  def age
    if birthdate.present?
      now = Date.today
      now.year - birthdate.year - ((now.month > birthdate.month || (now.month == birthdate.month && now.day >= birthdate.day)) ? 0 : 1)
    end
  end

  def male?
    gender == "m"
  end

  def female?
    gender == "f"
  end
end
