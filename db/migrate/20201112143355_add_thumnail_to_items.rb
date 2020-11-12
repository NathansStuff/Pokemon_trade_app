class AddThumnailToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :thumbnail, :string
  end
end
