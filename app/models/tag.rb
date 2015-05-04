class Tag < ActiveRecord::Base

  has_and_belongs_to_many :creatures
  validates :name,
    presence: true,
    length: {minimum: 1, maximum: 10}

end
