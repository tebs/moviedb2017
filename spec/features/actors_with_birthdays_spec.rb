require 'rails_helper'

feature "actors with birthdays today are displayed in the home page" do
  before do
      @actor = create :actor, birthdate: 35.years.ago
  end

  # here we can't use let because it's not executed until it's invoked
  # so when we load the page it's not in the database and therefore the
  # birthdays section has no content.
  # let(:actor) { create :actor, birthdate: 35.years.ago }

  specify do
    visit '/'

    expect(page).to have_css 'h1', text: 'Actors having a birthdate today!'

    actor_list = find('.actor-list')
    expect(actor_list).to have_css 'li', text: @actor.full_name
  end
end
