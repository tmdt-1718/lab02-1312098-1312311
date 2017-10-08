class Email < ApplicationRecord
    belongs_to :user
    
    validates :to, presence: true
    validates :subject, presence: true, length: {minimum: 3, maximum: 1000}
    validates :body, presence: true, length: {minimum: 3, maximum: 1000}

end
