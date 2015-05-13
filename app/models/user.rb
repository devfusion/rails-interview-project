class User < ActiveRecord::Base
  belongs_to :group

  has_many :emails, dependent: :destroy
  accepts_nested_attributes_for :emails, allow_destroy: true
end
