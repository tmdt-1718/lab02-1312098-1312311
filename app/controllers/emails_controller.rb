class EmailsController < ApplicationController
    before_action :set_email, only: [:show, :destroy]


    def new
        @email = Email.new
    end

    def create 
        @email = Email.new(email_params)
        @email.user = current_user
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

    def Email_sent
        @emails_sent= Email.find_by(user_id: current_user.id)
    end

    def Email_sent_show
        @email = Email.find(params[:id])
    end

    def Email_inbox
        @emails_inbox = Email.where(to: current_user.id).all
    end

    def Email_inbox_show
        @email = Email.find(params[:id])
    end


    private
        def email_params
            params.require(:email).permit(:to, :subject, :body)
        end

        def set_email
            @email = Email.find(params[:id])
        end
end
