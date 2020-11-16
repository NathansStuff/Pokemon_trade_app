class ItemsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_item, only: [:show, :edit, :update, :destroy]
  
    def index
      @items = Item.all

    end
  
    def show
      @user = @item.user
      @username = @user
      

      session = Stripe::Checkout::Session.create(
        payment_method_types: ['card'],
        customer_email: @user.email,
        line_items: [{
            name: @item.title,
            description: @item.description,
            images: [@item.thumbnail],
            amount: (@item.price * 100).to_i,
            currency: 'aud',
            quantity: 1,
        }],
        payment_intent_data: {
            metadata: {
                event_id: @item.id
            }
        },
        success_url: "#{root_url}charges/success?eventId=#{@item.id}",
        cancel_url: "#{root_url}events"
    )
    @session_id = session.id

    end
  
    def new
      @item = current_user.items.build
    end
  
    def edit
    end
  
    def create
      @item = current_user.items.build(item_params)
      @item.active = true

        if @item.save
            redirect_to @item
        else
            render 'new'
        end

    end
  
    def update
        authorize! :edit, @item
        if @item.update(item_params)
            redirect_to @item
        else
            render 'edit'
        end

    end
  
    def destroy
        authorize! :edit, @item
        @item.destroy
        redirect_to items_path
    end
  
    private
      # Share common setup or constraints between actions.
      def set_item
        @item = Item.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def item_params
        params.require(:item).permit(:title, :description, :thumbnail, :price, :condition, :set)
      end
  end
  