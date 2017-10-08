if Rails.env == 'development' || Rails.env == 'test'
    Rails.application.config.middleware.use OmniAuth::Builder do
        provider :facebook, ENV['FACEBOOK_KEY_DEV'], ENV['FACEBOOK_SECRET_DEV']
    end
    else
    # Production
    Rails.application.config.middleware.use OmniAuth::Builder do
        provider :facebook, ENV['FACEBOOK_KEY_PRO'], ENV['FACEBOOK_SECRET_PRO']
    end
end