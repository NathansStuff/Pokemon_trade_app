class ItemsController < ApplicationController
    before_action :ser_item, only: [:show, :edit, :update, :destroy]
  
    def index
      @items = Item.all
    end
  
    def show
    end
  
    def new
      @item = Item.new
    end
  
    def edit
    end
  
    def create
      @item = Item.new(item_params)

        if @item.save
            redirect_to @item
        else
            render 'new'
        end

    end
  
    def update
 
        if @item.update
            redirect_to @item
        else
            render 'edit'
        end

    end
  
    def destroy
        @link.destroy
        redirect_to items_path
    end
  
    private
      # Share common setup or constraints between actions.
      def set_link
        @link = Link.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def link_params
        params.require(:item).permit(:title, :description)
      end
  end
  