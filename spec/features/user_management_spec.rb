require 'spec_helper'
require_relative 'helpers/session'

include SessionHelpers

feature "User signs up" do

  scenario "when signing up" do
    expect{ sign_up }.to change(User, :count).by(1)
    expect(page).to have_content("Welcome, a@b.com")
    expect(User.first.email).to eq ("a@b.com")
  end

  scenario "with a password that doesn't match" do
    expect{ sign_up('b@c.com', 'pass', 'wrong') }.to change(User, :count).by 0
    expect(current_path).to eq ('/users')
    expect(page).to have_content("Sorry, your passwords don't match")
  end

  scenario "with an email that is already registered" do
    expect{ sign_up }.to change(User, :count).by 1
    expect{ sign_up }.to change(User, :count).by 0
    # expect(page).to have_content "This email is already registered"
    expect(page).to have_content "Email is already taken"
  end

end

feature "User signs in" do

  before(:each) do
    User.create(:email => "b@b.com",
                :password => "test",
                :password_confirmation => "test")
  end

  scenario "with correct credentials" do
    visit '/'
    expect(page).not_to have_content("Welcome, b@b.com")
    sign_in("b@b.com", "test")
    expect(page).to have_content("Welcome, b@b.com")
  end

  scenario "with incorrect credentials" do
    visit '/'
    expect(page).not_to have_content("Welcome, b@b.com")
    sign_in("b@b.com", "wrong")
    expect(page).not_to have_content("Welcome, b@b.com")
  end

end


feature "User signs out" do

  before(:each) do
    User.create(:email => "b@b.com",
                :password => "test",
                :password_confirmation => "test")
  end

  scenario "whilst already signed in" do
    sign_in("b@b.com", "test")
    click_button "Sign out"
    expect(page).to have_content("Good bye!")
    expect(page).not_to have_content("Welcome, b@b.com")
  end

end