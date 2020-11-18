module ItemsHelper
#------------------------------------------------------------------------------------------------
# Cool helper method that determines if the current user is the items owner
#------------------------------------------------------------------------------------------------
    def item_author(item)
        user_signed_in? && current_user.id == item.user_id
    end
end
