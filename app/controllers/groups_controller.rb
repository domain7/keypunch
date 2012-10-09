class GroupsController < ApplicationController
  before_filter :admin_only, :only => [ :new, :create, :edit, :update ]
  before_filter { |controller| controller.set_current_nav('groups') }

  layout 'entities'

  def index
  end

  def show
    @group = Group.find(params[:id])

    @entities = @group.entities
      .includes([:entity_roles,:entity_users])
      .where('entity_roles.role_id IN (?) OR entity_users.user_id = ?', current_user.roles.map{|x| x.id}, current_user.id)
  end

  def new
    @group = Group.new
    @group.ancestry = params[:group_id]
  end

  def create
    @group = Group.new(params[:group])

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
      else
        flash[:error] = @group.errors.full_messages.join('<br />')
        format.html { render action: "new" }
      end
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])

    respond_to do |format|
      if @group.update_attributes(params[:group])
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
      else
        flash[:error] = @group.errors.full_messages.join('<br />')
        format.html { render action: "edit" }
      end
    end
  end

end
