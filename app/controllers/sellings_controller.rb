class SellingsController < ApplicationController
    before_action :authenticate_user!
#-------------------------------------------------------------------------------
# Sets variables to use within the view and reduce view logic
#-------------------------------------------------------------------------------
    def index
        @current_count = Item.where(user_id: current_user.id, active: true).count
        @sold_count = Item.where(user_id: current_user.id, active: false).count
    end
    
#-------------------------------------------------------------------------------
# Sets variables to use within the view and reduce view logic
#-------------------------------------------------------------------------------
    def sold
        @items = Item.where(user_id: current_user.id, active: false)
    end
    
#-------------------------------------------------------------------------------
# Sets variables to use within the view and reduce view logic
#-------------------------------------------------------------------------------
    def current
        @items = Item.where(user_id: current_user.id, active: true)
    end
end
