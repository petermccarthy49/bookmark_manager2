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

end