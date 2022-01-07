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
  
  describe ('.three_most_recent') do
    it("returns the three most recently added products") do
      product1 = Product.create(name: "peppers", cost: 12, country_of_origin: "France")
      product2 = Product.create(name: "grapes", cost: 13, country_of_origin: "Spain")
      product3 = Product.create(name: "tomatoes", cost: 1, country_of_origin: "Japan")
      product4 = Product.create(name: "lettuce", cost: 14, country_of_origin: "Russia")
      product5 = Product.create(name: "peanut butter", cost: 7, country_of_origin: "Cameroon")
      expect(Product.three_most_recent).to(eq([product5, product4, product3]))
    end
  end

  describe ('.most_reviews') do
    it("returns the product with the most reviews") do
      product1 = Product.create(name: "peppers", cost: 12, country_of_origin: "France")
      product2 = Product.create(name: "grapes", cost: 13, country_of_origin: "Spain")
      product3 = Product.create(name: "tomatoes", cost: 1, country_of_origin: "Japan")
      review1 = Review.create(author: "mitch paper", content_body: "blah blah blah sjdk lkj ljasdf lkasdjflkj asdlkjasd sjdkjl aslkdjds", rating: 1, product_id: product1.id)
      review2 = Review.create(author: "sally paper", content_body: "blah blah zffdg sjdk lkj ljasdf lkasdjflkj asdlkjasd sjdkjl aslkdjds", rating: 2, product_id: product1.id)
      review3 = Review.create(author: "chet paper", content_body: "blah blah sdfg sjdk lkj ljasdf lkasdjflkj asdlkjasd sjdkjl aslkdjds", rating: 3, product_id: product1.id)
      review4 = Review.create(author: "bill paper", content_body: "blah blah gfds sjdk lkj ljasdf lkasdjflkj asdlkjasd sjdkjl aslkdjds", rating: 4, product_id: product2.id)
      review5 = Review.create(author: "steve paper", content_body: "blah blah hjjh sjdk lkj ljasdf lkasdjflkj asdlkjasd sjdkjl aslkdjds", rating: 5, product_id: product2.id)
      expect(Product.most_reviews).to(eq(product1))
    end
  end

  describe ('.usa') do
    it("returns products with a country of origin matching USA") do
      product1 = Product.create(name: "peppers", cost: 12, country_of_origin: "France")
      product2 = Product.create(name: "grapes", cost: 13, country_of_origin: "USA")
      product3 = Product.create(name: "tomatoes", cost: 1, country_of_origin: "USA")
      product4 = Product.create(name: "lettuce", cost: 14, country_of_origin: "Russia")
      product5 = Product.create(name: "peanut butter", cost: 7, country_of_origin: "Cameroon")
      expect(Product.usa).to(eq([product2, product3]))
    end
  end
end
