class EmailsController < ApplicationController
    before_action :set_email, only: [:show, :destroy, :Email_inbox_show, :Email_sent_show]
    before_action :require_user
    before_action :require_same_user, only: [ :Email_sent_show]


    def new
        @email = Email.new
        @friends = current_user.friends_with.order(:username)
    end

    def create 
        @email = Email.new(email_params)
        @email.user = current_user
        
        if @email.save
            UserEmailMailer.new_email(@email, @user_email).deliver_now
            flash[:success] = "Email was sent"
            redirect_to emails_sent_path
        else 
            render 'new'
        end
    end

    def show

    end


    def destroy

    end

    def Email_sent
        @emails_sent= Email.where(user_id: current_user.id).all
    end

    def Email_sent_show  
    end

    def Email_inbox
        @emails_inbox = Email.where(to: current_user.id).all.order('created_at DESC')
    end

    def Email_inbox_show
        @user_email = current_user.friends_with.find(@email.user_id).email
        if !@email.read
            UserEmailMailer.read_email(@email, @user_email).deliver_now
            @email.update(read: true)
        else 
            flash[:danger] = "You have been read this email"
            redirect_to emails_inbox_path
        end
    end


    private
        def email_params
            params.require(:email).permit(:to, :subject, :body)
        end

        def set_email
            @email = Email.find(params[:id])
        end

        

        def require_same_user
            if  current_user.id != @email.user_id
                flash[:danger] = "You can only see your email"
                redirect_to emails_inbox_path
            end
        end
end
