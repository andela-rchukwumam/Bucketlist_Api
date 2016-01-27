class List < ActiveRecord::Base
  belongs_to :user
  has_many :items, dependent: :destroy
  validates :name, presence: true, length: { minimum: 3 }

  def self.search(query)
    where("name ILIKE ?", "%#{query}%")
  end
end
