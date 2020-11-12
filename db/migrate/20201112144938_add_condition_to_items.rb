class AddConditionToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :condition, :string
  end
end
