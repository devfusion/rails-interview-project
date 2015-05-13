class ReportsController < ApplicationController
  
  def index
    @groups = Group.includes(:users => [:emails]).all

    render :json => @groups, :only => :name, :include => [:users => {:only => :name, :include => [:emails => {:only => :address}]}]
  end

  def new
  end

  def create
  end
end
