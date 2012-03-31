class Admin::FacultyController < ApplicationController
  before_filter :check_of_existence_administrator
  before_filter :check_for_administrating
  def new
    if request.post?
      faculty = Faculty.new(:name => params[:name])
      if faculty.save
        redirect_to :controller => 'admin/faculty', :action => 'index'
      else
        #проверка формы
      end
    end
  end

  def destroy
    faculty = Faculty.find(params[:id])
    faculty.destroy
    redirect_to :controller => "/admin/faculty", :action => "index"
  end

  def show
    @faculty = Faculty.find(params[:id])
  end

  def index
    @faculties = Faculty.all
  end

  def edit
    @faculty = Faculty.find(params[:id])
    if request.post?
      if @faculty.update_attributes(:name => params[:name])
        redirect_to :controller => 'admin/faculty', :action => 'index'
      else
        #проверка формы
      end
    end
  end
end
