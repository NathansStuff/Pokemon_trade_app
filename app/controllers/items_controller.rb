class ItemsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_item, only: [:show, :edit, :update, :destroy]
  
#-------------------------------------------------------------------------------
# Sets variables to use within the view and reduce view logic
#-------------------------------------------------------------------------------
    def index
      @items = Item.all

    end
  
#-------------------------------------------------------------------------------
# Sets variables to use within the view and reduce view logic
#-------------------------------------------------------------------------------
    def show
      @user = @item.user
      @username = @user
    end
  
#-------------------------------------------------------------------------------
# Creates a new item linked to the current user.
#-------------------------------------------------------------------------------
    def new
      @item = current_user.items.build
    end
  
    def edit
    end
  
#-------------------------------------------------------------------------------
# Creates a new item that is linked to the current user.
# Takes :title, :description, :thumbnail, :price, :set, and :condition params 
# Sets the :active parameter to true and uses all these parameters
# to add data to the message table with the correct attributes.
#-------------------------------------------------------------------------------
    def create
      @item = current_user.items.build(item_params)
      @item.active = true

        if @item.save
            redirect_to @item
        else
            render 'new'
        end

    end

#-------------------------------------------------------------------------------
# Uses the CanCanCan model to check if the user if authorised to edit this item
#-------------------------------------------------------------------------------
    def update
        authorize! :edit, @item
        if @item.update(item_params)
            redirect_to @item
        else
            render 'edit'
        end

    end

#-------------------------------------------------------------------------------
# Uses the CanCanCan model to check if the user if authorised to delete this item
#-------------------------------------------------------------------------------
    def destroy
        authorize! :edit, @item
        @item.destroy
        redirect_to items_path
    end
  
    private
#-------------------------------------------------------------------------------
# Share common setup or constraints between actions.
#-------------------------------------------------------------------------------
      def set_item
        @item = Item.find(params[:id])
      end
  
#-------------------------------------------------------------------------------
# Only allow a list of trusted parameters through.
#-------------------------------------------------------------------------------
      def item_params
        params.require(:item).permit(:title, :description, :thumbnail, :price, :condition, :set, :active)
      end
  end
  