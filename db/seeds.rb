require 'faker'

Merchandiser.destroy_all
Customer.destroy_all
Category.destroy_all
Order.destroy_all

categories = []
['best', 'health', 'fashion', 'travel', 'beauty', 'food'].each do |c|
  categories.push Category.create!(name: c)
end

merchandiser_username = 'darkjoke'
customer_username = 'sharpsteam'
common_password = 'foobar'

m1 = Merchandiser.create(
  username: merchandiser_username,
  password: common_password,
  password_confirmation: common_password,
  email: Faker::Internet.email,
  business_name: Faker::Company.unique.name,
  owner_name: Faker::Name.name,
  contact_number: Faker::PhoneNumber.cell_phone,
  business_number: Faker::Company.swedish_organisation_number,
  company_address: Faker::Address.full_address
)

categories.each do |c|
  p = m1.products.build(
    title: Faker::Alphanumeric.alpha(number: 10),
    price: Faker::Number.number(digits: 5),
    shipping_fee: 0,
    category_id: c.id,
    image: Rack::Test::UploadedFile.new(Rails.root.join("public/images/#{c.name}-1.jpg"), 'image/jpeg')
  )
  p.save
end

Product.all.each do |p|
  0.upto(2) do |i|
    temp_price = i.zero? ? p.price : p.price + Faker::Number.number(digits: 1)
    item = p.product_items.build(
      title: "#{i+1}_#{p.title} #{Faker::Alphanumeric.alpha(number: 5)}",
      price: temp_price,
      total_amount: Faker::Number.number(digits: 2),
      image: Rack::Test::UploadedFile.new(Rails.root.join("public/images/#{p.category.name}-1-#{i+1}.jpg"), 'image/jpeg')
    )
    item.save
  end
end

c1 = Customer.create(
  username: customer_username,
  name: Faker::Name.name,
  contact_number: Faker::PhoneNumber.cell_phone,
  address: Faker::Address.full_address,
  password: 'foobar',
  password_confirmation: 'foobar'
)

p1 = c1.purchases.create(
  purchase_number: Faker::Number.unique,
  shipping_fee: 0,
  recipient_name: Faker::Name.name,
  recipient_contact: Faker::PhoneNumber.cell_phone,
  recipient_address: Faker::Address.full_address,
  shipping_status: 2,
  confirm_status: 2,
  arrive_date: Faker::Time.between(from: DateTime.now - 2, to: DateTime.now)
)

p1.orders.create(
  quantity: 1,
  product_item_id: ProductItem.first.id,
)

c1.reviews.create(
  body: Faker::Company.bs,
  rating: 5,
  order_id: Order.first.id
)
