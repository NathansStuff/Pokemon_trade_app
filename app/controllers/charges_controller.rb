class ChargesController < ApplicationController
    def new
        @item = Item.find(params[:item])
    end

    def create
        # Amount in cents
        @amount = 500
      
        customer = Stripe::Customer.create({
          email: params[:stripeEmail],
          source: params[:stripeToken],
        })
      
        charge = Stripe::Charge.create({
          customer: customer.id,
          amount: @amount,
          description: 'Rails Stripe customer',
          currency: 'aud',
        })
      
      rescue Stripe::CardError => e
        flash[:error] = e.message
        redirect_to new_charge_path
      end
      
      def success
      end
end
