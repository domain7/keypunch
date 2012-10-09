class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!

  layout 'application'

  def sort_order
    default = sort_column
    sql_order = []
    sort_array = (sort_column.to_s).gsub(/[\s;'\"]/,'').split(/,/)
    sort_array.each do |c|
      sql_order << c + " #{sort_direction == 'desc' ? 'desc' : 'asc'}"
    end
    sql_order.join(', ')
  end

  def sort_direction
    params[:direction] || "asc"
  end

  def set_current_nav(name)
    @main_nav = name
  end

  protected

  def admin_only
    render_403 unless current_user.role? :admin
  end

  def render_404
    render :file => 'public/404', :status => 404, :layout => false
    return false
  end

  def render_403
    render :file => 'public/403', :status => 403, :layout => false
    return false
  end

  rescue_from CanCan::AccessDenied do |exception|
    render_403
  end
end
