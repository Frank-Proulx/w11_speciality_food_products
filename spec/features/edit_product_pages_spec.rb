require 'rails_helper'

describe "the update a product process as an admin" do
  it "updates a product as an admin" do
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
    click_on 'Fancy Peppers'
    click_on 'Edit'
    fill_in 'Name', :with => 'Green Peppers'
    fill_in 'Cost', :with => '7'
    fill_in 'Country of origin', :with => 'Spain'
    click_on 'Update Product'
    expect(page).to have_content 'Product successfully updated!'
    expect(page).to have_content 'Green Peppers'
    expect(page).to have_no_content 'Fancy Peppers'
  end
end

describe "the update a product process as a non admin user" do
  it "confirms a non-admin user can't update a product" do
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
    click_on 'Fancy Peppers'
    click_on 'Edit'
    expect(page).to have_content 'All Products'
  end
end

describe "the update a product process as a non user" do
  it "confirms a non user can't update a product" do
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
    click_on 'Fancy Peppers'
    click_on 'Edit'
    expect(page).to have_content 'Log in'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end