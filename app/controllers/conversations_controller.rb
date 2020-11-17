class ConversationsController < ApplicationController
  before_action :authenticate_user! 
  
#-------------------------------------------------------------------------------
# Sets variables to use within the view and reduce view logic
#-------------------------------------------------------------------------------
  def index
    @users = User.all
    @conversations = Conversation.all
  end  
  
#-------------------------------------------------------------------------------
# Creates a new conversation
# If an existing conversation between two users already exists, uses that conversation
# instead of creating a new one. If none exists, creates a new one.
# Redirects to the conversation view.
#-------------------------------------------------------------------------------
  def create  
    if Conversation.between(params[:sender_id], params[:recipient_id]).present? 
       @conversation = Conversation.between(params[:sender_id], params[:recipient_id]).first
    else
       @conversation = Conversation.create!(conversation_params)
    end    
    
    redirect_to conversation_messages_path(@conversation)
  end  
  
  private
#-------------------------------------------------------------------------------
# Only allow a list of trusted parameters through.
#-------------------------------------------------------------------------------
  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end
end