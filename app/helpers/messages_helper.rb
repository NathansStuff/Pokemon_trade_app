module MessagesHelper

    def get_message_notifications
        if Conversation.any?
            # c1 = Conversation.where(:sender_id == current_user.id)
            # u1 = Message.where(read = false).where(conversation_id: [c1]).count

            # c2 = Conversation.where(:recipient_id == current_user.id)
            # u2 = Message.where(read = false).where(conversation_id: [c2]).count

            # @unread_messages = u1 + u2

            conversations = Conversation.where(:sender_id == current_user.id) + Conversation.where(:recipient_id == current_user.id)
            @unread_messages = Message.where(read = false).where(conversation_id: [conversations]).count
            if @unread_messages != 0
                p "You have #{pluralize(@unread_messages, 'unread message' )}"
            end
        end
    end
end