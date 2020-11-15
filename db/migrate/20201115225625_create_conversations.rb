class CreateConversations < ActiveRecord::Migration[6.0]
  def change
    create_table :conversations do |t|
      t.text :body
      t.integer :sender_id
      t.integer :recipient_id
      t.references :conversations, index: true
      t.references :users, index: true      
      
      t.timestamps
    end
  end
end
