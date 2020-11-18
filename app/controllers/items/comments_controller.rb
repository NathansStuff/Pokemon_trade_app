class Items::CommentsController < CommentsController
    before_action :set_commentable
    private

#-------------------------------------------------------------------------------
# Lets the comment know what item it belongs to when entered into the database
#-------------------------------------------------------------------------------
    def set_commentable
        @commentable = Item.find(params[:item_id])
    end
end
