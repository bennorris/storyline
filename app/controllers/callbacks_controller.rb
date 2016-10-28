class CallbacksController < Devise::OmniauthCallbacksController

    def facebook
      @user = User.from_omniauth(request.env["omniauth.auth"])
      sign_in_and_redirect @user

      # if @user == User.find_by(email: request.env["omniauth.auth"].info.email)
      #   @user.update(uid: request.env["omniauth.auth"].uid, username: request.env["omniauth.auth"].name )
      #   @user.save
      #   sign_in_and_redirect @user
      # else
      #   @user = User.from_omniauth(request.env["omniauth.auth"])
        # sign_in_and_redirect @user
      # end
    end
  end
