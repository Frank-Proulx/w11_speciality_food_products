require 'rails_helper'

describe "the add a review process as a user" do
  before :each do
    user = User.create({email: 'example@email.com', password: 'testing', admin: true})
    visit '/'
    click_link 'Sign In'
    fill_in 'Email', :with => 'example@email.com'
    fill_in 'Password', :with => 'testing'
    click_on 'Log in'
    visit products_path
    click_link 'Add new product'
    fill_in 'Name', :with => 'Stinky Peppers'
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
    visit products_path
  end

  it "adds a new review as a user" do
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

describe "the add a review process as a non admin user" do
  it "confirms a non user can't add a review" do
    user = User.create({email: 'example@email.com', password: 'testing', admin: true})
    visit '/'
    click_link 'Sign In'
    fill_in 'Email', :with => 'example@email.com'
    fill_in 'Password', :with => 'testing'
    click_on 'Log in'
    visit products_path
    click_link 'Add new product'
    fill_in 'Name', :with => 'Stinky Peppers'
    fill_in 'Cost', :with => '5'
    fill_in 'Country of origin', :with => 'France'
    click_on 'Create Product'
    click_on 'Sign Out'
    visit products_path
    click_link 'Stinky Peppers'
    click_link 'Add a review'
    expect(page).to have_content 'Log in'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end