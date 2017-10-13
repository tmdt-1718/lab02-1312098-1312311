class UserEmailMailer < ApplicationMailer

    def new_email(email, user_email)
        @email = email
        
        mail to: user_email,
            subject: "[You have new email in Email app]"
    end
end
