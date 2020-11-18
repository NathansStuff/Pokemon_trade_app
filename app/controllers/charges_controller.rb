class ChargesController < ApplicationController    
      def success
        # @item=Item.find(params[:id])
        redirect_to items_path, notice: "You have successfully bought an item!"

      end

      def webhook
        payment_id= params[:data][:object][:payment_intent]
        payment = Stripe::PaymentIntent.retrieve(payment_id)
        
        item_id = payment.metadata.item_id
        item = Item.find(item_id)
        puts "purple"
        puts item
        item.active = false
        item.update()
        item.save
        item.save!
        puts "??????????????????"
        puts item

        user_id = payment.metadata.user_id
        item = Item.find(item_id)
        
        # redirect_to item_path(item, item: { active: false} )
    end    
end