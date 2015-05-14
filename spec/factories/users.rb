require 'faker'

FactoryGirl.define do
  factory :user do
    group
    name    { Faker::Name.name }
  end
end