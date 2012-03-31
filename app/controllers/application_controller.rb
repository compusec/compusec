#coding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  def check_of_existence_administrator
    if User.first == nil
      redirect_to :controller => "/user/register", :action => "step1"
      flash[:notice] = "В системе нет зарегистрированных пользователей, поэтому после успешной регистрации вы автоматически станете администратором"
    end
  end

  def check_for_administrating
    if session[:user_id] != 1
      redirect_to(:controller => '/pages/home', :action => 'index')
    end
  end

  def authorize
    unless session[:user_id]
      redirect_to(:controller => "/user/login", :action => "login")
    end
  end
end
