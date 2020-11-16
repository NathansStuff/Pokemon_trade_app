class Item < ApplicationRecord
    before_destroy :not_referenced_by_any_line_item
    belongs_to :user
    has_many :line_items
    has_rich_text :description
    has_one_attached :thumbnail
    has_many :comments, as: :commentable

    private
    def note_referenced_by_any_line_item
        unless line_items.empty?
            errors.add(:base, 'Cart items present')
            throw :abort
        end
    end
end