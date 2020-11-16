class Cart < ApplicationRecord
    has_many :line_items, dependent: :destroy

    def add_item(item)
        current_item = item_items.find_by(item_id: item_id)

        if current_item
            current_item.incremenet(:quantity)
        else
            current_item = line_items.build(item_id: item_id)
        end
        current_item
    end

    def total_price
        line_items.to_a.sum { |item| item.price }
    end
end
