class SellingsController < ApplicationController
    before_action :authenticate_user!
    def index
        @items = Item.all
        @count = 0
        for item in @items
            if item.user == current_user
                @count +=1
            end
        end
    end
end
