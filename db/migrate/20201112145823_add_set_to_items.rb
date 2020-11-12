class AddSetToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :set, :string
  end
end
