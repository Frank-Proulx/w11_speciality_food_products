require 'rails_helper'

describe "the delete a review process" do
  it "deletes a review" do
    visit products_path
    click_link 'Add new product'
    fill_in 'Name', :with => 'Fancy Peppers'
    fill_in 'Cost', :with => '5'
    fill_in 'Country of origin', :with => 'France'
    click_on 'Create Product'
    click_link 'Fancy Peppers'
    click_link 'Add a review'
    fill_in 'Author', :with => 'Mike Tyson'
    fill_in 'Content body', :with => 'blalsjdf sdkjhl lkajshdf laksdj kljashdfl hasldkjfh alskdjfhalsdjkfh alskdjhflaksdjhf'
    fill_in 'Rating', :with => '4'
    click_on 'Create Review'
    click_on 'Delete'
    expect(page).to have_no_content 'Mike Tyson'
  end
end