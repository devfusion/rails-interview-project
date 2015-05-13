class ReportsController < ApplicationController
  
  def index
    @groups = Group.all
  end

  def all_reports
    @groups = Group.includes(:users => [:emails]).all

    render :json => @groups, :only => :name, :include => [:users => {:only => :name, :include => [:emails => {:only => :address}]}]
  end

  def group_reports
    @groups = Group.includes(:users => [:emails]).find(params[:id])

    render :json => @groups, :only => :name, :include => [:users => {:only => :name, :include => [:emails => {:only => :address}]}]
  end

end
