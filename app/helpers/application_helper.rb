module ApplicationHelper

    def stripe_url
    # "https://connect.stripe.com/oauth/authorize?response_type=code&client_id=#{Rails.application.credentials.dig(:stripe, :connect_client_id)}&scope=read_write"
        "https://connect.stripe.com/express/oauth/authorize?response_type=code&client_id=#{Rails.application.credentials.dig(:stripe, :connect_client_id)}&scope=read_write"

    end


        # "https://connect.stripe.com/express/oauth/authorize?response_type=code&client_id=#{Rails.application.credentials.dig(:stripe, :connect_client_id)}&scope=read_write"


    def stripe_connect_button
        link_to stripe_url, class: "btn-stripe-connect" do
            content_tag :span, "Connect with Stripe"
        end
    end

    def profile_avatar
        if current_user.avatar.attached?
            image_tag(current_user.avatar_thumbnail)
        else
            image_tag('default_avatar.png')
        end
    end
    
    def users_profile_avatar(user)
        if user.avatar.attached?
            image_tag(user.avatar_thumbnail)
        else
            image_tag('default_avatar.png')
        end
    end

end
