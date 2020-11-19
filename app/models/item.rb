class Item < ApplicationRecord
    belongs_to :user
    has_rich_text :description
    has_one_attached :thumbnail
    has_many :comments, as: :commentable
    validates :title, length: { minimum: 10 }
    validates :description, length: { minimum: 20 }
    validates :price, numericality: { other_than: 0 }
    validates :thumbnail, presence: true, content_type: ['image/png', 'image/jpg', 'image/jpeg']
end