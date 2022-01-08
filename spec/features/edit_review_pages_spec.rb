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
    click_link 'Add a review'
    fill_in 'Author', :with => 'Mike Tyson'
    fill_in 'Content body', :with => 'blalsjdf sdkjhl lkajshdf laksdj kljashdfl hasldkjfh alskdjfhalsdjkfh alskdjhflaksdjhf'
    fill_in 'Rating', :with => '4'
    click_on 'Create Review'
    click_link 'Mike Tyson'
    click_on 'Edit review'
    fill_in 'Author', :with => 'Bernie Sanders'
    fill_in 'Content body', :with => 'adsf asdfasd asdfasdf asdfasdfsadf asdfasdfasdf asdfasdfasdf asdfasdfasdf asdfasdf'
    fill_in 'Rating', :with => '2'
    click_on 'Update Review'
    expect(page).to have_content 'Review successfully updated!'
    expect(page).to have_content 'Bernie Sanders'
    expect(page).to have_no_content 'Mike Tyson'
  end
end