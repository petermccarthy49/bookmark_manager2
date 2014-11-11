require 'spec_helper'

feature "User adds a new link" do
  scenario "when browsing the homepage" do
    expect(Link.count).to eq 0
    visit '/'
    add_link("http://www.google.com", "google")
    expect(Link.count).to eq 1
    link = Link.first
    expect(link.url).to eq "http://www.google.com"
    expect(link.title).to eq "google"
  end


  scenario 'with a few tags' do
    visit '/'
    add_link("http://www.bbc.co.uk", "bbc", ['news', 'entertainment'])
    link = Link.first
    expect(links.tags).to include('news')
    expect(links.tags).to include('entertainment')
  end


  def add_link(url, title, tags = [])
    within('#new-link') do
      fill_in 'url', :with => url
      fill_in 'title', :with => title
      fill_in 'tags', :with => tags.join(' ')
      click_button 'Add link'
    end
  end


end