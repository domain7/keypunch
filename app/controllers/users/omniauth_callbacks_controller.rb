class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  protect_from_forgery :except => :google_apps

  def google_apps
    @user = User.find_for_googleapps_oauth(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      flash[:success] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google Apps"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.googleapps_data"] = request.env["omniauth.auth"]
      redirect_to_new_user_registration_url
    end
  end

  def passthru
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end

end
