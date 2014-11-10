require 'spec_helper'


describe 'Link' do

  it 'can create a link and add it to the database' do
    # expect(Link.count).to eq 0
    Link.create(:title => "google", :url => "http:///www.google.com/")
    expect(Link.count).to eq 1
  end

end