class Admin::UserController < ApplicationController
  before_filter :check_of_existence_administrator
  before_filter :check_for_administrating
  def new
    if request.post?
      user = User.new(:email => params[:email],
                      :password => params[:password],
                      :password_confirmation => params[:password_confirmation],
                      :activated => true,
                      :banned => false,
                      :last_name => params[:last_name],
                      :first_name => params[:first_name],
                      :middle_name => params[:middle_name],
                      :middle_name => params[:middle_name],
                      :sex_id => params[:sex],
                      :chair_id => params[:chair],
                      :military_rank_id => params[:military_rank],
                      :scientific_rank_id => params[:scientific_rank],
                      :post_id => params[:post],
                      :phone => params[:phone],
                      :room => params[:room])
      if user.save
        redirect_to :controller => '/admin/user', :action => 'index'
      else
        #проверка формы
      end
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to :controller => "/admin/user", :action => "index"
  end

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
    if request.post?
      if @user.update_attributes(:email => params[:email],
                                 :password => params[:password],
                                 :activated => true,
                                 :banned => false,
                                 :last_name => params[:last_name],
                                 :first_name => params[:first_name],
                                 :middle_name => params[:middle_name],
                                 :middle_name => params[:middle_name],
                                 :sex_id => params[:sex],
                                 :chair_id => params[:chair],
                                 :military_rank_id => params[:military_rank],
                                 :scientific_rank_id => params[:scientific_rank],
                                 :post_id => params[:post],
                                 :phone => params[:phone],
                                 :room => params[:room])
        redirect_to :controller => 'admin/user', :action => 'index'
      else
        #проверка формы
      end
    end
  end

  def activate
    @user = User.find(params[:id])
    @user.update_attributes(:activated => true)
    redirect_to :controller => 'admin/user', :action => 'index'
  end
end
