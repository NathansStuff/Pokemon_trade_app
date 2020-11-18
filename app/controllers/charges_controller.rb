class ChargesController < ApplicationController  
  skip_before_action :verify_authenticity_token, only: [:webhook]  
#-------------------------------------------------------------------------------
# Upon successful payment, sets a notice and redirects the page to the items index page
#-------------------------------------------------------------------------------  
  def success
      redirect_to items_path, notice: "You have successfully bought an item!"
      @item=Item.find(params[:itemId])
      @item.active = false
  end
end