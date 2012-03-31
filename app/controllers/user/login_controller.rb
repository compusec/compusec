#coding: utf-8
class User::LoginController < ApplicationController
  before_filter :check_of_existence_administrator
  def login
    session[:user_id] = nil
    if request.post?
      if params[:email] == ""
        flash.now[:email] = "введите email"
      elsif !User.find_by_email(params[:email])
        flash.now[:email] = "неверный email"
      elsif params[:password] == ""
        flash.now[:password] = "введите пароль"
      else
        user = User.authenticate(params[:email].downcase, params[:password])
        if user
          if user.id != 1
            if user.activated?
              if user.banned?
                flash.now[:email] = "пользователь с таким email забанен"
              else
                session[:user_id] = user.id
                redirect_to :controller => "/pages/home", :action => "index"
              end
            else
              flash.now[:email] = "пользователь с таким email не активирован"
            end
          else
            session[:user_id] = user.id
            redirect_to :controller => "/pages/admin", :action => "index"
          end
        else
          flash.now[:password] = "неверный пароль"
        end
      end
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to :controller => "/user/login", :action => "login"
  end

end