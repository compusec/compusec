#coding: utf-8
class User::RegisterController < ApplicationController
  def step1
    if request.post?
      session[:user] = User.new
      session[:email] = params[:email].downcase
      session[:password] = params[:password]
      session[:password_confirmation] = params[:password_confirmation]
      if request.xhr?
        (validate_step1_xhr?)? (render "next_to_step2"): (render :text => "error")
      else   
        (validate_step1_no_xhr?)? (render "step2"): (render "step1")
      end
    else
      clear_session
    end
  end

  def step2
    unless request.post? && session[:user]
      redirect_to :action => "step1"
    else    
      session[:last_name] = params[:last_name]
      session[:first_name] = params[:first_name]
      session[:middle_name] = params[:middle_name]
      session[:sex] = params[:sex]
      if request.xhr?
        if params[:commit] == "Далее" 
          (validate_step2_xhr?)? (render "next_to_step3"): (render :text => "error")
        elsif params[:commit] == "Назад"
          render "back_to_step1"
        elsif params[:commit] == "Завершить"
          (validate_step2_xhr?)? (save_user_on_step2): (render :text => "error")
        end
      else
        if params[:commit] == "Далее" 
          (validate_step2_no_xhr?)? (render "step3"): (render "step2")
        elsif params[:commit] == "Назад"
          render "step1"
        elsif params[:commit] == "Завершить"
          (validate_step2_no_xhr?)? (save_user_on_step2): (render "step2")
        end
      end
    end
  end



  def step3 
    unless request.post? && session[:user]
      redirect_to :action => "step1"
    else
      session[:phone] = params[:phone]
      session[:room] = params[:room]
      session[:post] = params[:post]
      session[:military_rank] = params[:military_rank]
      session[:scientific_rank] = params[:scientific_rank]
      session[:chair] = params[:chair]
      session[:faculty] = params[:faculty]
      if request.xhr?
        if params[:commit] == "Назад"
          render "back_to_step2"
        elsif params[:commit] == "Завершить"
          (validate_step3_xhr?)? (save_user_on_step3): (render :text => "error")
        end
      else
        if params[:commit] == "Назад"
          render "step2"
        elsif params[:commit] == "Завершить"
          (validate_step3_no_xhr?)? (save_user_on_step3): (render "step3")
        end
      end
    end
  end

  def step4

  end


  def update_chair_select
    if params[:id] == "0"
      render(:partial => "chair", :locals => {:chairs => Chair.all})
    else
      chairs = Faculty.find(params[:id]).chairs
      chairs = Chair.all if chairs.empty?
      render(:partial => "chair", :locals => {:chairs => chairs})
    end    
  end

  def validate_uniqueness_email
    if User.find_by_email(params[:email])
      render :text => "false"
    else
      render :text => "true"
    end
  end


  def clear_session
    session[:email] = session[:password] = session[:password_confirmation] = session[:last_name] = session[:first_name] = session[:middle_name] = session[:sex] = session[:phone] = session[:room] = session[:faculty] = session[:chair] = session[:military_rank] = session[:post] = session[:scientific_rank]= nil
  end

  def validate_step1?
    session[:password] == session[:password_confirmation] &&
    session[:password] =~ /^([a-z0-9\?\'\+\-\_\<\>\"\;\`\:\!\@\#\$\%\^\&\*\(\)\{\}\[\]\,\.\/\\\|])+$/i &&
    session[:password].length >= 5 &&
    session[:password].length <= 30 &&
    password_strength(session[:password]) > 3 &&
    session[:email] =~ /^([a-z0-9_\-\.]+\@([a-z0-9_\-\.])+\.([a-z]{2,4}))$/i &&
    session[:email] != "" &&
    session[:password] != "" &&
    User.find_by_email(session[:email]) == nil
  end

  def password_strength(password)
    strength = 0;
    password = password.split(//)
    digits = '1234567890'.split(//);
    lwr = 'abcdefghijklmnopqrstuvwxyz'.split(//);
    upr = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split(//);
    spec_symbols = "?'+-_<>\";`:!@\#$%^&*(){}[],./\\|".split(//);
    for symbol in password
      if digits.include?(symbol)
        strength = strength + 1;
        break;
      end
    end
    for symbol in password
      if lwr.include?(symbol)
        strength = strength + 1;
        break;
      end
    end
    for symbol in password
      if upr.include?(symbol)
        strength = strength + 1;
        break;
      end
    end
    for symbol in password
      if spec_symbols.include?(symbol)
        strength = strength + 1;
        break;
      end
    end
    if password.length > 7
      strength = strength + 1;
    end
    return strength;
  end

  def validate_step1_xhr?
    validate_step1?
  end

  def validate_step1_no_xhr?
    unless validate_step1?
      if session[:email] == ""
        flash.now[:email] = "введите email"
      elsif params[:email] !~ /^([a-z0-9_\-\.]+\@([a-z0-9_\-\.])+\.([a-z]{2,4}))$/i
        flash.now[:email] = "некорректный email"
      elsif  User.find_by_email(session[:email]) != nil
        flash.now[:email] = "пользователь с таким email уже зарегистрирован"
      end       
      if session[:password] == ""
        flash.now[:password] = "введите пароль"
      elsif session[:password].length < 5
        flash.now[:password] = "пароль слишком короткий"
      elsif session[:password].length > 30
        flash.now[:password] = "пароль слишком длинный"
      elsif session[:password] !~ /^([a-z0-9\?\'\+\-\_\<\>\"\;\`\:\!\@\#\$\%\^\&\*\(\)\{\}\[\]\,\.\/\\\|])+$/i
        flash.now[:password] = "пароль должен состоять только из латинских букв, цифр и спец-символов: ?'+-_<>\";`:!@\#$%^&*(){}[],./\\| "
      elsif password_strength(session[:password]) <= 3
        flash.now[:password] = "слабый пароль"
      elsif password_strength(session[:password]) == 4
        flash.now[:password] = "средний пароль"
      elsif session[:password_confirmation] == ""
        flash.now[:password_confirmation] = "подтвердите пароль"
      elsif session[:password_confirmation] != session[:password]
        flash.now[:password_confirmation] = "пароли не совпадают"
      end
      return false
    end
    return true
  end

  def validate_step2?
    session[:last_name] != "" &&
    session[:middle_name] != "" &&
    session[:first_name] != "" &&
    session[:last_name] =~ /^([а-я])+$/i &&
    session[:middle_name] =~ /^([а-я])+$/i &&
    session[:first_name] =~ /^([а-я])+$/i
  end

  def validate_step2_xhr?
    validate_step2?
  end

  def validate_step2_no_xhr?
    unless validate_step2?
      if session[:last_name] == ""
        flash.now[:last_name] = "введите фамилию"
      elsif session[:last_name] !~ /^([а-я])+$/i
        flash.now[:last_name] = "фамилия введена некорректно"
      end
      if session[:first_name] == ""
        flash.now[:first_name] = "введите имя"
      elsif session[:first_name] !~ /^([а-я])+$/i
        flash.now[:first_name] = "имя введено некорректно"
      end
      if session[:middle_name] == ""
        flash.now[:middle_name] = "введите отчество"
      elsif session[:middle_name] !~ /^([а-я])+$/i
        flash.now[:middle_name] = "отчество введено некорректно"
      end
      return false
    end
    return true
  end

  def validate_step3?
    session[:phone] == "" || session[:phone] =~ /^[0-9]{11}$/
  end

  def validate_step3_xhr?
    validate_step3?
  end

  def validate_step3_no_xhr?
    unless validate_step3?
      flash.now[:phone] = "некорректный номер телефона"
      return false
    end
    return true
  end

  def save_user_on_step2
    session[:user].email = session[:email]
    session[:user].password = session[:password]
    session[:user].password_confirmation = session[:password_confirmation]
    session[:user].last_name = session[:last_name]
    session[:user].first_name = session[:first_name]
    session[:user].middle_name = session[:middle_name]
    session[:user].sex_id = session[:sex]
              
    clear_session
  
    if User.first == nil
      session[:user_id] = 1
      render "step4", :locals => {:is_admin => true}
    else
      render "step4", :locals => {:is_admin => false}
    end
    session[:user].save
    log = Log.new(:content => "Пользователь #{session[:user].email} подал заявку на регистрацию")
    log.user_id = session[:user].id
    log.save
    log = nil
    session[:user] = nil
  end

  def save_user_on_step3
    session[:user].email = session[:email]
    session[:user].password = session[:password]
    session[:user].password_confirmation = session[:password_confirmation]
    session[:user].last_name = session[:last_name]
    session[:user].first_name = session[:first_name]
    session[:user].middle_name = session[:middle_name]
    session[:user].sex_id = session[:sex]
    session[:user].chair_id = session[:chair]
    session[:user].military_rank_id = session[:military_rank]
    session[:user].scientific_rank_id = session[:scientific_rank]
    session[:user].post_id = session[:post]
    session[:user].phone = session[:phone]
    session[:user].room = session[:room]
              
    clear_session
              
    if User.first == nil
      session[:user_id] = 1
      render "step4", :locals => {:is_admin => true}
    else
      render "step4", :locals => {:is_admin => false}
    end
    session[:user].save
    log = Log.new(:content => "Пользователь #{session[:user].email} подал заявку на регистрацию")
    log.user_id = session[:user].id
    log.save
    log = nil
    session[:user] = nil
  end

end

