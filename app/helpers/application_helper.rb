module ApplicationHelper

#-------------------------------------------------------------------------------
# Defines the Stripe URL for later use
# Uses encrypted information to build the URL so Stripe knows what application you come from
#-------------------------------------------------------------------------------
    def stripe_url
        "https://connect.stripe.com/express/oauth/authorize?response_type=code&client_id=#{Rails.application.credentials.dig(:stripe, :connect_client_id)}&scope=read_write"
    end
#-------------------------------------------------------------------------------
# Uses the above URL to build the button that connects you to stripe
#-------------------------------------------------------------------------------
    def stripe_connect_button
        link_to stripe_url, class: "btn btn-primary btn-block" do
            content_tag :span, "Connect with Stripe"
        end
    end
#-------------------------------------------------------------------------------
# Sets the user's profile avatar, as seen. 
# Uses either the default or their own uploaded avatar.
#-------------------------------------------------------------------------------
    def profile_avatar
        if current_user.avatar.attached?
            image_tag(current_user.avatar_thumbnail)
        else
            image_tag('default_avatar.png')
        end
    end
#-------------------------------------------------------------------------------
# Sets other user's profiler avatar.
#-------------------------------------------------------------------------------
    def users_profile_avatar(user)
        if user.avatar.attached?
            image_tag(user.avatar_thumbnail)
        else
            image_tag('default_avatar.png')
        end
    end
end
