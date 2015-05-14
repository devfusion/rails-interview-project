require 'faker'

FactoryGirl.define do
  factory :email do
    user
    address   { Faker::Internet.email }
  end
end