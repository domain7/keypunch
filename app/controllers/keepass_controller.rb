class KeepassController < ApplicationController
  before_filter :admin_only

  def index
  end

  def new
  end

  def create
    require 'xml'
    e_count = Entity.count
    g_count = Group.count
    Entity.load_keepass( params['keepass']['filename'].tempfile.path )
    g_count = Group.count - g_count
    e_count = Entity.count - e_count
    respond_to do |format|
      format.html { redirect_to entities_path, notice: "#{e_count} Entities imported, #{g_count} Groups imported." }
    end
  end

end
