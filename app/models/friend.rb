class Friend < ApplicationRecord
    belongs_to :user, class_name: "User"
    belongs_to :friend, class_name: "User"
                                  
    validates :user_id, presence: true
    validates :friend_id, presence: true

    def block?(id_user)
        debbuger
        friend = Friend.find_by(user_id: current_user.id, friend_id: id_user)
        friend.block
    end
  
end
