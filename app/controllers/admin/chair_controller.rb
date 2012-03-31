class Admin::ChairController < ApplicationController
  before_filter :check_of_existence_administrator
  before_filter :check_for_administrating
  def new
    if request.post?
      chair = Chair.new(:name => params[:name],
                        :faculty_id => params[:faculty])
      if chair.save
        redirect_to :controller => 'admin/chair', :action => 'index'
      else
        #проверка формы
      end
    end
  end

  def destroy
    chair = Chair.find(params[:id])
    chair.destroy
    redirect_to :controller => "/admin/chair", :action => "index"
  end

  def show
    @chair = Chair.find(params[:id])
  end

  def index
    if request.post?
      @chairs = Faculty.find(params[:id]).chairs
    else
      @chairs = Chair.all
    end

  end

  def edit
    @chair = Chair.find(params[:id])
    if request.post?
      if @chair.update_attributes(:name => params[:name],
                                  :faculty_id => params[:faculty])
        redirect_to :controller => 'admin/chair', :action => 'index'
      else
        #проверка формы
      end
    end
  end
end
