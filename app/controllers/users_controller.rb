class UsersController < ApplicationController
  
  def show
    @group = Group.includes(:users).find(params[:group_id])
    @user = @group.users.find(params[:id])
  end

  def new
    @group = Group.find(params[:group_id])
    @user = @group.users.build
  end

  def create
    @group = Group.find(params[:group_id])
    @user = @group.users.build(permitted_params)
    if @user.save
      redirect_to group_path(@group)
    else
      redirect_to group_path(@group)
    end
  end

  def edit
    @group = Group.includes(:users).find(params[:group_id])
    @user = @group.users.find(params[:id])
  end

  def update
    @group = Group.includes(:users).find(params[:group_id])
    @user = @group.users.find(params[:id])
    @user.update_attributes(permitted_params)
    redirect_to group_path(@group)
  end

  def destroy
     group = Group.includes(:users).find(params[:group_id])
     user = group.users.find(params[:id])
     user.destroy
     redirect_to group_path(group)
  end

  private

  def permitted_params
    params.require(:user).permit(:name, :emails_attributes => [:address])
  end

end
