require 'rails_helper'

describe "the update a review process as an admin" do
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
    click_on 'Fancy Peppers'
    click_link 'Add a review'
    fill_in 'Author', :with => 'Mike Tyson'
    fill_in 'Content body', :with => 'blalsjdf sdkjhl lkajshdf laksdj kljashdfl hasldkjfh alskdjfhalsdjkfh alskdjhflaksdjhf'
    fill_in 'Rating', :with => '4'
    click_on 'Create Review'
  end
  
  it "updates a review as an admin" do
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

  it "tests the flash message for when a review fails to update" do
    click_link 'Mike Tyson'
    click_on 'Edit review'
    fill_in 'Author', :with => ''
    fill_in 'Content body', :with => ''
    fill_in 'Rating', :with => ''
    click_on 'Update Review'
    expect(page).to have_content 'Failed to update review.'
  end
end

describe "the update a review process as a non admin user" do
  it "confirms a non-admin user can't update a review" do
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
    click_link 'Add a review'
    fill_in 'Author', :with => 'Mike Tyson'
    fill_in 'Content body', :with => 'blalsjdf sdkjhl lkajshdf laksdj kljashdfl hasldkjfh alskdjfhalsdjkfh alskdjhflaksdjhf'
    fill_in 'Rating', :with => '4'
    click_on 'Create Review'
    click_on 'Sign Out'
    user2 = User.create({email: 'user@email.com', password: 'testing'})
    visit '/'
    click_link 'Sign In'
    fill_in 'Email', :with => 'user@email.com'
    fill_in 'Password', :with => 'testing'
    click_on 'Log in'
    click_link 'Fancy Peppers'
    click_link 'Mike Tyson'
    click_on 'Edit review'
    expect(page).to have_content 'All Products'
  end
end

describe "the update a review process as a non user" do
  it "confirms a non user can't update a review" do
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
    click_link 'Add a review'
    fill_in 'Author', :with => 'Mike Tyson'
    fill_in 'Content body', :with => 'blalsjdf sdkjhl lkajshdf laksdj kljashdfl hasldkjfh alskdjfhalsdjkfh alskdjhflaksdjhf'
    fill_in 'Rating', :with => '4'
    click_on 'Create Review'
    click_on 'Sign Out'
    click_link 'Fancy Peppers'
    click_link 'Mike Tyson'
    click_on 'Edit review'
    expect(page).to have_content 'Log in'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end