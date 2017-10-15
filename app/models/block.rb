class Block < ApplicationRecord
    belongs_to :user, class_name: "User"
    belongs_to :block, class_name: "User"
                                  
    validates :user_id, presence: true
    validates :block_id, presence: true
end
