class Group < ActiveRecord::Base
  has_many :users, dependent: :destroy
  accepts_nested_attributes_for :users, allow_destroy: true

  validates :name, presence: true
end
