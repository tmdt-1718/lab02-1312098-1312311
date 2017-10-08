class EmailsController < ApplicationController
    before_action :set_email, only: [:show, :destroy]

    def index
        @emails = Email.all
    end

    def new
        @email = Email.new
    end

    def create 
        @email = Email.new(email_params)
        if @email.save
            flash[:success] = "Email was sent"
            redirect_to emails_path
        else 
            render 'new'
        end
    end

    def show

    end


    def destroy

    end

    private
        def email_params
            params.require(:email).permit(:to, :subject, :body)
        end

        def set_email
            @email = Email.find(params[:id])
        end
end
