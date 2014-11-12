require 'spec_helper'

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


  def sign_up(email = "a@b.com", 
              password = "oranges!",
              password_confirmation = "oranges!")
    visit '/users/new'
    expect(page.status_code).to eq(200)
    fill_in :email, :with => email
    fill_in :password, :with => password
    fill_in :password_confirmation, :with => password_confirmation
    click_button "Sign up"
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
    expect(page).to have_content("Welcome, b@b.com")
  end

  def sign_in(email, password)
    visit '/sessions/new'
    fill_in :email, :with => email
    fill_in :password, :with => password
    click_button 'Sign in'
  end


end