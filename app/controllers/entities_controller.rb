class EntitiesController < ApplicationController
  load_and_authorize_resource
  before_filter :admin_only, :only => :destroy
  before_filter :find_group, only: [:new]
  before_filter { |controller| controller.set_current_nav('passwords') }

  helper_method :sort_order,:sort_column,:sort_direction
  layout 'entities'

  def show_password
    entity = Entity.find(params[:id])
    authorize! :edit, entity
    # this one's for you, shane
    pyoksok = entity.decrypt

    respond_to do |format|
      format.json { render :json => pyoksok.to_json }
    end
  end

  def index
    s = params[:search_phrase]
    @entities = Entity
      .search(s)
      .includes([:entity_roles,:entity_users,:groups])
      .where('entity_roles.role_id IN (?) OR entity_users.user_id = ?', current_user.roles.map{|x| x.id}, current_user.id)
      .order(sort_order)
      .paginate(:page => params[:page], :per_page => 50)

  end

  def show
    @entity = Entity.find(params[:id])
    @versions = @entity.versions.limit(10).reverse
  end

  def new
    if @group
      @entity = Entity.new(:group_ids => [@group.id])
    else
      @entity = Entity.new
    end

    @group_options = Group.all
  end

  def create
    @entity = Entity.new(params[:entity])

    respond_to do |format|
      if @entity.save
        format.html { redirect_to @entity, notice: 'Password was successfully created.' }
      else
        @group_options = Group.all
        flash[:error] = @entity.errors.full_messages.join('<br />')
        format.html { render action: "new" }
      end
    end
  end

  def edit
    @entity = Entity.find(params[:id])
    @group_options = Group.all
  end

  def update
    @entity = Entity.find(params[:id])

    if params[:entity][:password].blank?
      params[:entity].delete('password')
      params[:entity].delete('password_confirmation')
    end

    respond_to do |format|
      if @entity.update_attributes(params[:entity])
        format.html { redirect_to @entity, notice: 'Password was successfully updated.' }
      else
        @group_options = Group.all
        flash[:error] = @entity.errors.full_messages.join('<br />')
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @entity = Entity.find(params[:id])
    @entity.destroy

    respond_to do |format|
      format.html { redirect_to entities_path, notice: 'Password was successfully deleted.' }
    end
  end

  private

  def find_group
    g = Group.find_by_id params[:group_id]
    if g and g.is_childless?
      @group = g
    end
  end

  def sort_column
    params[:sort] || "entities.name, entities.created_at"
  end
end
