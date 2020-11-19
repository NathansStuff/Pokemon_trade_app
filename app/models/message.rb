class Message < ApplicationRecord
    belongs_to :conversation
    belongs_to :user  
    validates :body, presence: true
    
    validates_presence_of :body, :conversation_id, :user_id

#-------------------------------------------------------------------------------
# Logic here, as it applies to message class items across multiple controller views
#-------------------------------------------------------------------------------
    def message_time
        created_at.strftime(" %d/%m/%y at %l:%M %p")
    end
  end