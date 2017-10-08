class User < ApplicationRecord

    before_save {self.email = email.downcase}

    validates :username, presence: true, 
                uniqueness: { case_sensitive: false}, length: {minimum: 3, maximum: 25}
    
                VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i    
    validates :email, presence: true, length: {maximum: 105},
                uniqueness: { case_sensitive: false},
                format: { with: VALID_EMAIL_REGEX }
    has_secure_password

    mount_uploader :avatar, ImageUploader

    def self.sign_in_from_omniauth(auth)
        find_by(provider: auth['provider'], uid: auth['uid']) || create_user_from_omniauth(auth)
    end

    def self.create_user_from_omniauth(auth)
        create! do |user|
            user.provider = auth['provider']
            user.uid = auth['uid']
            user.password = "123456"
            if auth['info']
              user.username = auth['info']['name'] || ""
              user.email = auth['info']['email'] || ""
              user.remote_avatar_url = auth['info']['image'] || ""
            end
        end
    end
end
