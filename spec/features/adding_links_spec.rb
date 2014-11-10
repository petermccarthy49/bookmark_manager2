require 'spec_helper'

feature "User adds a new link" do
  scenario "when browsing the homepage" do
    expect(Link.count).to eq 0
    visit '/'
    add_link("http://www.google.com", "google")
    expect(link.count).to eq 1
    link = Link.first
    expect(link.url).to eq "http://www.google.com"
    expect(link.title).to eq "google"
  end


  def add_link(url, title)
    within('#new-link') do
      fill_in 'url', :with => url
      fill_in 'title', :with => title
      click_button 'Add link'
    end
  end


end