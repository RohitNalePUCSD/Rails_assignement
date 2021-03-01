class UsersController < ApplicationController
    protect_from_forgery with: :null_session

    def register
      @user = User.create(user_params)
      if @user.save
        render(json: {message: "User Create successfully!!!"}, status: :created)
      else
        render(json: { message: @user.errors }, status: :bad)
      end
    end

    private
      def user_params
        params.require(:user).permit(:email, :password)
      end
end
