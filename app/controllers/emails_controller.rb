class EmailsController < ApplicationController
  def new
    @group = Group.includes(:users).find(params[:group_id])
    @user = @group.users.find(params[:user_id])
    @email = @user.emails.build
  end

  def create
    @group = Group.includes(:users).find(params[:group_id])
    @user = @group.users.find(params[:user_id])
    @email = @user.emails.build(permitted_params)
    if @email.save
      redirect_to group_user_path(@group, @user)
    else
      flash[:error] = @email.errors.full_messages
      render 'new'
    end
  end

  def edit
    @group = Group.includes(:users => [:emails]).find(params[:group_id])
    @user = @group.users.find(params[:user_id])
    @email = @user.emails.find(params[:id])
  end

  def update
    @group = Group.includes(:users => [:emails]).find(params[:group_id])
    @user = @group.users.find(params[:user_id])
    @email = @user.emails.find(params[:id])
    if @email.update_attributes(permitted_params)
      redirect_to group_user_path(@group, @user)
    else
      flash[:error] = @email.errors.full_messages
      render 'edit'
    end
  end

  def destroy
     group = Group.includes(:users => [:emails]).find(params[:group_id])
     user = group.users.find(params[:user_id])
     email = user.emails.find(params[:id])
     email.destroy
     redirect_to group_user_path(group, user)
  end

  private

  def permitted_params
    params.require(:email).permit(:address)
  end
end
