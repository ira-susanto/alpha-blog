class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { in: 3..25 }

  has_many :article_categories
  has_many :articles, through: :article_categories
end
