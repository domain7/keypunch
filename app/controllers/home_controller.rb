class HomeController < ActionController::Base
  def index
    redirect_to entities_path, :flash => flash if current_user
  end

  layout 'home'
end
