class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.text :body
      t.references :conversations, index: true
      t.references :users, index: true      
      t.integer :conversation_id
      t.integer :user_id
      
      t.timestamps
    end
  end
end
