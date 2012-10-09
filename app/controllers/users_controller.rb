class UsersController < ApplicationController
  before_filter :admin_only
  before_filter { |controller| controller.set_current_nav('users') }

  layout 'entities'

  def index
    @users = User.paginate(:page => params[:page], :per_page => 50)
  end

  def show
    @user = User.find params[:id]
  end

  def edit
    @roles = Role.all
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    unless params[:user][:password].blank?
      @user.password = params[:user][:password]
      @user.password_confirmation = params[:user][:password_confirmation]
      params[:user].delete('password')
      params[:user].delete('password_confirmation')
    end

    respond_to do |format|
      if @user.update_attributes(params[:user], :as => :admin)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
      else
        flash[:error] = @user.errors.full_messages.join('<br />')
        @roles = Role.all
        format.html { render action: "edit" }
      end
    end
  end

end
