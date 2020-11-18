class CommentsController < ApplicationController
    before_action :authenticate_user!
    
#-------------------------------------------------------------------------------
# Creates a new comment linked to the current user.
# Takes :body params through comment_params function.
#-------------------------------------------------------------------------------
    def create
        @comment = @commentable.comments.new(comment_params)
        @comment.user = current_user
        @comment.save
        redirect_to @commentable, notice: "You have posted a comment."
    end

    private
#-------------------------------------------------------------------------------
# Only allow a list of trusted parameters through.
#-------------------------------------------------------------------------------
    def comment_params
        params.require(:comment).permit(:body)
    end
end
