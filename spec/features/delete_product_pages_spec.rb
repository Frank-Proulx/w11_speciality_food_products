require 'rails_helper'

describe "the delete a product process as a non admin user" do
  before :each do
    user = User.create({email: 'example@email.com', password: 'testing', admin: true})
    visit '/'
    click_link 'Sign In'
    fill_in 'Email', :with => 'example@email.com'
    fill_in 'Password', :with => 'testing'
    click_on 'Log in'
    click_link 'Add new product'
    fill_in 'Name', :with => 'Fancy Peppers'
    fill_in 'Cost', :with => '5'
    fill_in 'Country of origin', :with => 'France'
    click_on 'Create Product'
    click_on 'Sign Out'
    user2 = User.create({email: 'user@email.com', password: 'testing'})
    visit '/'
    click_link 'Sign In'
    fill_in 'Email', :with => 'user@email.com'
    fill_in 'Password', :with => 'testing'
    click_on 'Log in'
  end

  it "confirms a non-admin user can't delete a product" do
    visit products_path
    click_on 'Fancy Peppers'
    click_on 'Delete'
    expect(page).to have_content 'All Products'
    expect(page).to have_content 'Fancy Peppers'
  end
end

describe "the delete a product process as an admin" do
  before :each do
    user = User.create({email: 'example@email.com', password: 'testing', admin: true})
    visit '/'
    click_link 'Sign In'
    fill_in 'Email', :with => 'example@email.com'
    fill_in 'Password', :with => 'testing'
    click_on 'Log in'
  end

  it "deletes a product" do
    visit products_path
    click_link 'Add new product'
    fill_in 'Name', :with => 'Fancy Peppers'
    fill_in 'Cost', :with => '5'
    fill_in 'Country of origin', :with => 'France'
    click_on 'Create Product'
    click_on 'Fancy Peppers'
    click_on 'Delete'
    expect(page).to have_no_content 'Fancy Peppers'
  end
end

describe "the delete a product process as a non admin user" do
  it "confirms a non user can't delete a product" do
    user = User.create({email: 'example@email.com', password: 'testing', admin: true})
    visit '/'
    click_link 'Sign In'
    fill_in 'Email', :with => 'example@email.com'
    fill_in 'Password', :with => 'testing'
    click_on 'Log in'
    click_link 'Add new product'
    fill_in 'Name', :with => 'Fancy Peppers'
    fill_in 'Cost', :with => '5'
    fill_in 'Country of origin', :with => 'France'
    click_on 'Create Product'
    click_on 'Sign Out'
    click_link 'Fancy Peppers'
    click_on 'Delete'
    expect(page).to have_content 'Log in'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end