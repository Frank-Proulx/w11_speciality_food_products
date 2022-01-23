require 'rails_helper'

describe "the add a product process as a non admin user" do
  before :each do
    user = User.create({email: 'user@email.com', password: 'testing'})
    visit '/'
    click_link 'Sign In'
    fill_in 'Email', :with => 'user@email.com'
    fill_in 'Password', :with => 'testing'
    click_on 'Log in'
  end

  it "confirms a non admin can't add a product" do
    visit products_path
    click_link 'Add new product'
    expect(page).to have_content 'All Products'
    expect(page).to have_content 'You must be an admin to perform this action.'
  end
end

describe "the add a product process as an admin" do
  before :each do
    user = User.create({email: 'example@email.com', password: 'testing', admin: true})
    visit '/'
    click_link 'Sign In'
    fill_in 'Email', :with => 'example@email.com'
    fill_in 'Password', :with => 'testing'
    click_on 'Log in'
  end

  it "adds a new product" do
    visit products_path
    click_link 'Add new product'
    fill_in 'Name', :with => 'Fancy Peppers'
    fill_in 'Cost', :with => '5'
    fill_in 'Country of origin', :with => 'France'
    click_on 'Create Product'
    expect(page).to have_content 'Product successfully added!'
    expect(page).to have_content 'Fancy Peppers'
  end

  it "gives an error when no name is entered" do
    visit new_product_path
    click_on 'Create Product'
    expect(page).to have_content "Name can't be blank"
  end

  it "gives an error when no name is entered" do
    visit new_product_path
    click_on 'Create Product'
    expect(page).to have_content "Name can't be blank"
  end

  it "gives an error when no cost is entered" do
    visit new_product_path
    click_on 'Create Product'
    expect(page).to have_content "Cost can't be blank"
  end

  it "gives an error when no country of origin is entered" do
    visit new_product_path
    click_on 'Create Product'
    expect(page).to have_content "Country of origin can't be blank"
  end
end

describe "the add a product process as a non user" do
  it "confirms a non user can't add a product" do
    visit products_path
    click_link 'Add new product'
    expect(page).to have_content 'Log in'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end