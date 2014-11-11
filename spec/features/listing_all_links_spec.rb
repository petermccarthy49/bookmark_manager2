require 'spec_helper'

feature "User browses the list of links" do

  before(:each) {
    Link.create(:url => "http://www.google.com", 
                :title => "google",
                :tags => [Tag.first_or_create(:text => "search")])
  
    Link.create(:url => "http://www.bbc.co.uk", 
                :title => "bbc",
                :tags => [Tag.first_or_create(:text => "news")])
  }


  scenario 'when opening the homepage' do
    visit '/'
    expect(page).to have_content("google")
  end


  scenario 'filtered by tag' do
    visit '/tags/search'
    expect(page).not_to have_content("bbc")
    expect(page).to have_content("google")
  end


end