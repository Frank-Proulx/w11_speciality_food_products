require 'rails_helper'

describe "the delete a product process" do
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