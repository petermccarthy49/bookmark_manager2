require 'spec_helper'

feature "User signs up" do

  scenario "when logging in" do
    expect{ sign_up }.to change(User, :count).by(1)
    expect(page).to have_content("Welcome, a@b.com")
    expect(User.first.email).to eq ("a@b.com")
  end


  def sign_up(email = "a@b.com", password = "oranges!")
    visit '/users/new'
    expect(page.status_code).to eq(200)
    fill_in :email, :with => email
    fill_in :password, :with => password
    click_button "Sign up"
  end

end