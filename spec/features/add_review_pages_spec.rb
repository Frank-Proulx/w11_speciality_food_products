require 'rails_helper'

describe "the add a review process" do
  before :each do
    visit products_path
    click_link 'Add new product'
    fill_in 'Name', :with => 'Stinky Peppers'
    fill_in 'Cost', :with => '5'
    fill_in 'Country of origin', :with => 'France'
    click_on 'Create Product'
  end

  it "adds a new review" do
    click_link 'Stinky Peppers'
    click_link 'Add a review'
    fill_in 'Author', :with => 'Mike Tyson'
    fill_in 'Content body', :with => 'blalsjdf sdkjhl lkajshdf laksdj kljashdfl hasldkjfh alskdjfhalsdjkfh alskdjhflaksdjhf'
    fill_in 'Rating', :with => '4'
    click_on 'Create Review'
    expect(page).to have_content 'Review successfully added!'
    expect(page).to have_content 'Mike Tyson'
  end

  it "gives an error when no author is entered" do
    click_link 'Stinky Peppers'
    click_link 'Add a review'
    click_on 'Create Review'
    expect(page).to have_content "Author can't be blank"
  end

  it "gives an error when no content is entered" do
    click_link 'Stinky Peppers'
    click_link 'Add a review'
    click_on 'Create Review'
    expect(page).to have_content "Content body can't be blank"
  end

  it "gives an error when no rating is entered" do
    click_link 'Stinky Peppers'
    click_link 'Add a review'
    click_on 'Create Review'
    expect(page).to have_content "Rating can't be blank"
  end
end