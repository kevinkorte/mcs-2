class DashboardController < ApplicationController
    
    def show
        if user_signed_in?
            if current_user.username.present?
                @user = current_user.username
            else
                @user = current_user.email
            end
        end
    end
    
end
