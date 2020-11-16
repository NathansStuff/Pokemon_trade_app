class ChargesController < ApplicationController    
      def success
        redirect_to items_path, notice: "You have successfully bought an item!"
      end
end
