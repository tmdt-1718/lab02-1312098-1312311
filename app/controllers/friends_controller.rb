class FriendsController < ApplicationController

    def index
        @friends = current_user.friends_with
    end

    def show

    end

    private

end
