require 'rails_helper'

describe "the update a product process" do
  it "updates a product" do
    visit products_path
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