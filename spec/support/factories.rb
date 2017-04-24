require 'ffaker'

FactoryGirl.define do

  factory :item do
    name { FFaker::Product.product_name }
    price [9.0, 19.99, 29.99].sample
    unit 'GBP'
  end

  factory :order do
    email { FFaker::Internet.email }
    address { FFaker::AddressBR.street_address }
    city { FFaker::AddressBR.city }
    state { FFaker::AddressBR.state }
    zip { FFaker::AddressBR.zip_code }
    status "draft"
  end

  factory :order_item do

  end

  factory :discount do
    promo_code ['20%OFF']
    value 20
    type PercentageDiscount
  end

  factory :percentage_discount do
  end

  factory :fixed_discount do
  end
end
