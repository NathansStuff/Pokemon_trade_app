class MessagesController < ApplicationController
  
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end
  
  def index
#-------------------------------------------------------------------------------
# Finds all messages for the current conversation.
# Creates a new message attached to the current conversation.
#-------------------------------------------------------------------------------
    @messages = @conversation.messages
    @message = @conversation.messages.new
  end
#-------------------------------------------------------------------------------
# Creates a new message
#-------------------------------------------------------------------------------
  def new
    @message = @conversation.messages.new
  end  

#-------------------------------------------------------------------------------
# Creates a new message that is linked to the conversation id.
# Takes :user_id and :body params to add data to the message table with the correct attributes.
#-------------------------------------------------------------------------------
  def create
    @message = @conversation.messages.new(message_params)
    if @message.save
      redirect_to conversation_messages_path(@conversation)
    end
  end  
  
  private
#-------------------------------------------------------------------------------
# Only allow a list of trusted parameters through.
#-------------------------------------------------------------------------------
  def message_params
    params.require(:message).permit(:body, :user_id)
  end
end