class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(permitted_params)
    if @group.save
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    @group.update_attributes(permitted_params)
    redirect_to root_path
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to root_path
  end

  private

  def permitted_params
    params.require(:group).permit(:name, :users_attributes => [:name, :emails_attributes => [:address]])
  end

end
