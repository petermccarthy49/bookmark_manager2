require 'spec_helper'

feature "User browses the list of links" do

  before(:each) {
    Link.create(:url => "http://www.google.com", 
                :title => "google")
  }

  scenario 'when opening the homepage' do
    visit '/'
    expect(page).to have_content("google")
  end

end