class WelcomeController < ApplicationController
    def home
        redirect_to emails_inbox_path if logged_in?
    end
    
    def about

    end
end
