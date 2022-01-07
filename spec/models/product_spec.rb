require 'rails_helper'

describe Product do
  it { should have_many(:reviews) }
  it { should validate_presence_of :name }
  it { should validate_presence_of :cost }
  it { should validate_presence_of :country_of_origin }
  it { should validate_numericality_of(:cost).only_integer }
  it("titleizes the name of an product") do
    product = Product.create({name: "the famous mario spaghetti", cost: 7, country_of_origin: "France"})
    expect(product.name()).to(eq("The Famous Mario Spaghetti"))
  end
end