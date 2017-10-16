class EmailsController < ApplicationController
    before_action :set_email, only: [:Email_inbox_show, :Email_sent_show]
    before_action :require_user
    before_action :require_same_user, only: [:Email_sent_show]
    before_action :require_read_email_sent, only: [:Email_inbox_show]

    def new
        @email = Email.new
        @friends = current_user.friends_with.order(:username)
    end

    def create 
        @emails = params[:email]
        @emails[:to].shift if @emails[:to].count > 1
        @success = 1
        @emails[:to].each do |to|
            @email = Email.new(to: to, user_id: current_user.id, subject: params[:email][:subject], body: params[:email][:body])
            @user_email = User.find(to).email
            if @email.save
                UserEmailMailer.new_email(@email, @user_email).deliver_now
            else 
                @friends = current_user.friends_with.order(:username)
                render 'new'
            end
            
        end
        if @success == 1
            flash[:success] = "Email was sent"
            redirect_to emails_sent_path
        end
     
    end


    def Email_sent
        @emails_sent= Email.where(user_id: current_user.id).all.order('created_at DESC')
    end

    def Email_sent_show  
    end

    def Email_inbox
        if params[:id]

            @emails_inbox = Email.where(to: current_user.id).where('id < ?', params[:id]).limit(17).order('created_at DESC')
        else
            @emails_inbox = Email.where(to: current_user.id).limit(17).order('created_at DESC')

        end

        respond_to do |format|
            format.html
            format.js
        end

    end
    def Email_inbox_show
        @user_email = Email.find(params[:id]).user.email
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
                flash[:danger] = "You can only see your email sent"
                redirect_to emails_sent_path
            end
        end

        def require_read_email_sent
            if current_user.id != @email.to
                flash[:danger] = "You can only see your email inbox"
                redirect_to emails_inbox_path
            end
        end
end
