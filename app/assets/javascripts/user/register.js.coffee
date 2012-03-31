# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->

  $(document).ready(()->
    $("#email").focus();
  )

  $("#email").live("keydown", () -> 
    setTimeout(validate_email, 10)
    )
  
  $("#email").live("change", () -> 
    setTimeout(validate_email, 10)
    )

  $("#password").live("keydown", () -> 
    setTimeout(validate_password, 10) 
    )

  $("#password_confirmation").live("keydown", () -> 
    setTimeout(validate_password_confirmation, 10)
    )

  $("#next_to_step2").live("click", () -> 
     setTimeout(validate_step1, 10)
     )

  $("#last_name").live("keydown", () -> 
     setTimeout(validate_last_name, 10)
     )

  $("#first_name").live("keydown", () -> 
     setTimeout(validate_first_name, 10)
     )

  $("#middle_name").live("keydown", () -> 
     setTimeout(validate_middle_name, 10)
     )

  $("#next_to_step3").live("click", () -> 
     setTimeout(validate_step2, 10)
     )

  $("#next_to_step4").live("click", () -> 
     setTimeout(validate_step3, 10)
     )

  $("#faculty").live("change", () -> 
    setTimeout(change_faculty, 10)
    )

  $("#phone").live("keydown", () -> 
     setTimeout(validate_phone, 10)
     )

  $("#room").live("keydown", () -> 
     setTimeout(validate_room, 10)
     )

  validate_email = ()->
    if $("#email").val()
      reg = /^([a-z0-9_\-]+\.)*[a-z0-9_\-]+\@([a-z0-9][a-z0-9\-]*[a-z0-9]\.)+[a-z]{2,4}$/i;
      val = $("#email").val();
      if reg.test(val)
        jQuery.post('/register/validate_uniqueness_email', {email: $("#email").val()},(data)->
          (if data != "true"
             $("#email").css("background", "rgba(255, 0, 0, 0.2)");
             $("#error_email").text("пользователь с таким email уже зарегистрирован");
           else  
             $("#email").css("background", "rgba(0, 255, 0, 0.2)");
             $("#error_email").text("")));
       else
         $("#email").css("background","rgba(255, 0, 0, 0.2)");
         $("#error_email").text("некорректный email");
    else
      $("#email").css("background", "white");
      $("#error_email").text("");

  validate_password = ()->
    $("#password").css("background", "white");
    $("#error_password").text("");
    $("#password_confirmation").css("background", "white");
    $("#error_password_confirmation").text("");
    if $("#password_confirmation").val()
      if $("#password").val()
        reg = /^([a-z0-9\?\'\+\-\_\<\>\"\;\`\:\!\@\#\$\%\^\&\*\(\)\{\}\[\]\,\.\/\\\|])+$/i;
        val = $("#password").val();
        if reg.test(val)
          if $("#password").val().length >= 5
            if $("#password").val().length <= 30
              strength = password_strength($("#password").val());
              if (strength > 3)
                if (strength == 4)
                  $("#password").css("background", "rgba(255, 255, 0, 0.2)");
                else
                  $("#password").css("background", "rgba(0, 255, 0, 0.2)");
                if $("#password").val() == $("#password_confirmation").val()
                  $("#password_confirmation").css("background", "rgba(0, 255, 0, 0.2)");
                else
                  $("#password_confirmation").css("background", "rgba(255, 0, 0, 0.2)");
                  $("#error_password_confirmation").text("пароли не совпадают");
              else
                $("#password").css("background", "rgba(255, 0, 0, 0.2)");
                $("#error_password").text("слабый пароль");
            else
              $("#password").css("background", "rgba(255, 0, 0, 0.2)");
              $("#error_password").text("пароль слишком длинный");
          else
            $("#password").css("background", "rgba(255, 0, 0, 0.2)");
            $("#error_password").text("пароль слишком короткий");
        else
          $("#password").css("background", "rgba(255, 0, 0, 0.2)");
          $("#error_password").text("пароль должен состоять только из латинских букв, цифр и спец-символов: ?'+-_<>\";`:!@#$%^&*(){}[],./\\| ");
      else
        $("#password_confirmation").css("background", "rgba(255, 0, 0, 0.2)");
        $("#error_password_confirmation").text("пароли не совпадают");
    else
      if $("#password").val()
        reg = /^([a-z0-9\?\'\+\-\_\<\>\"\;\`\:\!\@\#\$\%\^\&\*\(\)\{\}\[\]\,\.\/\\\|])+$/i;
        val = $("#password").val();
        if reg.test(val)
          if $("#password").val().length >= 5
            if $("#password").val().length <= 30
              strength = password_strength($("#password").val());
              if (strength > 3)
                if (strength == 4)
                  $("#password").css("background", "rgba(255, 255, 0, 0.2)");
                  $("#error_password").text("средний пароль");
                else
                  $("#password").css("background", "rgba(0, 255, 0, 0.2)");
              else
                $("#password").css("background", "rgba(255, 0, 0, 0.2)");
                $("#error_password").text("слабый пароль");
            else
              $("#password").css("background", "rgba(255, 0, 0, 0.2)");
              $("#error_password").text("пароль слишком длинный"); 
          else
            $("#password").css("background", "rgba(255, 0, 0, 0.2)");
            $("#error_password").text("пароль слишком короткий"); 
        else
          $("#password").css("background", "rgba(255, 0, 0, 0.2)");
          $("#error_password").text("пароль должен состоять только из латинских букв, цифр и спец-символов: ?'+-_<>\";`:!@#$%^&*(){}[],./\\| ");

  password_strength = (password) ->
    strength = 0;
    digits = '1234567890';
    lwr = 'abcdefghijklmnopqrstuvwxyz';
    upr = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    spec_symbols = "?'+-_<>\";`:!@#$%^&*(){}[],./\\|";
    for symbol in password
      if digits.indexOf(symbol, 0) != -1
        ++strength;
        break;
    for symbol in password
      if lwr.indexOf(symbol, 0) != -1
        ++strength;
        break;
    for symbol in password
      if upr.indexOf(symbol, 0) != -1
        ++strength;
        break;
    for symbol in password
      if spec_symbols.indexOf(symbol, 0) != -1
        ++strength;
        break;
    if password.length > 7
      ++strength;
    return strength;

  validate_password_confirmation = ()->
    if $("#password_confirmation").val()
      if $("#password").val()
        reg = /^([a-z0-9.-_])+$/i;
        val = $("#password").val();
        if $("#password").val().length >= 5 && $("#password").val().length <= 30 && reg.test(val)
          if $("#password_confirmation").val() == $("#password").val()
            $("#password_confirmation").css("background", "rgba(0, 255, 0, 0.2)");
            $("#error_password_confirmation").text("");
          else
            $("#password_confirmation").css("background", "rgba(255, 0, 0, 0.2)");
            $("#error_password_confirmation").text("пароли не совпадают");
      else
        $("#password_confirmation").css("background", "rgba(255, 0, 0, 0.2)");
        $("#error_password_confirmation").text("пароли не совпадают");
    else
      $("#password_confirmation").css("background", "white");
      $("#error_password_confirmation").text("");

  validate_step1 = () ->
    if $("#email").val()
      if $("#email").css("backgroundColor") == "rgba(0, 255, 0, 0.2)"
        if $("#password").val()
          if $("#password").css("backgroundColor") == "rgba(0, 255, 0, 0.2)"
            if $("#password_confirmation").val()
              if $("#password_confirmation").css("backgroundColor") == "rgba(255, 0, 0, 0.2)"
                $("#password_confirmation").focus(); 
            else
              $("#password_confirmation").focus(); 
              $("#password_confirmation").css("background", "rgba(255, 0, 0, 0.2)");
              $("#error_password_confirmation").text("подтвердите пароль"); 
          else
            $("#password").focus(); 
        else
          $("#password").focus(); 
          $("#password").css("background", "rgba(255, 0, 0, 0.2)");
          $("#error_password").text("введите пароль");      
      else
        $("#email").focus();
        if $("#password").val()
          if $("#password").css("backgroundColor") == "rgba(0, 255, 0, 0.2)"
            if !$("#password_confirmation").val() 
              $("#password_confirmation").css("background", "rgba(255, 0, 0, 0.2)");
              $("#error_password_confirmation").text("подтвердите пароль"); 
        else
          $("#password").css("background", "rgba(255, 0, 0, 0.2)");
          $("#error_password").text("введите пароль");     
    else
      $("#email").focus(); 
      $("#email").css("background", "rgba(255, 0, 0, 0.2)");
      $("#error_email").text("введите email");
      if $("#password").val()
        if $("#password").css("backgroundColor") == "rgba(0, 255, 0, 0.2)"
          if !$("#password_confirmation").val() 
            $("#password_confirmation").css("background", "rgba(255, 0, 0, 0.2)");
            $("#error_password_confirmation").text("подтвердите пароль"); 
      else
        $("#password").css("background", "rgba(255, 0, 0, 0.2)");
        $("#error_password").text("введите пароль");
 
  validate_last_name = ()->
    if $("#last_name").val()
      val = $("#last_name").val()
      reg = /^([а-я])+$/i
      if reg.test(val)
        if val.length > 30
          $("#last_name").css("background", "rgba(255, 0, 0, 0.2)");
          $("#error_last_name").text("фамилия слишком длинная");
        else
          $("#last_name").css("background", "rgba(0, 255, 0, 0.2)");
          $("#error_last_name").text("");
      else
        $("#last_name").css("background", "rgba(255, 0, 0, 0.2)");
        $("#error_last_name").text("фамилия введена некорректно");
    else
      $("#last_name").css("background", "white");
      $("#error_last_name").text("");
  
  validate_first_name = ()->
    if $("#first_name").val()
      val = $("#first_name").val()
      reg = /^([а-я])+$/i
      if reg.test(val)
        if val.length > 30
          $("#first_name").css("background", "rgba(255, 0, 0, 0.2)");
          $("#error_first_name").text("имя слишком длинное");
        else
          $("#first_name").css("background", "rgba(0, 255, 0, 0.2)");
          $("#error_first_name").text("");
      else
        $("#first_name").css("background", "rgba(255, 0, 0, 0.2)");
        $("#error_first_name").text("имя введено некорректно");
    else
      $("#first_name").css("background", "white");
      $("#error_first_name").text("");

  validate_middle_name = ()->
    if $("#middle_name").val()
      val = $("#middle_name").val()
      reg = /^([а-я])+$/i
      if reg.test(val)
        if val.length > 30
          $("#middle_name").css("background", "rgba(255, 0, 0, 0.2)");
          $("#error_middle_name").text("отчество слишком длинное");
        else
          $("#middle_name").css("background", "rgba(0, 255, 0, 0.2)");
          $("#error_middle_name").text("");
      else
        $("#middle_name").css("background", "rgba(255, 0, 0, 0.2)");
        $("#error_middle_name").text("отчество введено некорректно");
    else
      $("#middle_name").css("background", "white");
      $("#error_middle_name").text("");

  validate_step2 = () -> 
    if !$("#last_name").val()
      $("#last_name").css("background", "rgba(255, 0, 0, 0.2)");
      $("#error_last_name").text("введите фамилию");
    if !$("#first_name").val()
      $("#first_name").css("background", "rgba(255, 0, 0, 0.2)");
      $("#error_first_name").text("введите имя");
    if !$("#middle_name").val()
        $("#middle_name").css("background", "rgba(255, 0, 0, 0.2)");
        $("#error_middle_name").text("введите отчество");
    if $("#last_name").css("backgroundColor") != "rgba(0, 255, 0, 0.2)"
      $("#last_name").focus();
    else if $("#td_first_name").css("backgroundColor") != "rgba(0, 255, 0, 0.2)"
      $("#first_name").focus();
    else if $("#middle_name").css("backgroundColor") != "rgba(0, 255, 0, 0.2)"
      $("#middle_name").focus();

  change_faculty = () ->
    faculty = $("select#faculty :selected").val();
    faculty = 0 unless faculty;
    jQuery.get('/register/update_chair_select/' + faculty, (data)->($("#chair").html(escape_javascript(data))));
    
  validate_phone = ()->
    if $("#phone").val()
      val = $("#phone").val()
      reg = /^[0-9]{11}$/i
      if reg.test(val)
        $("#phone").css("background", "rgba(0, 255, 0, 0.2)");
        $("#error_phone").text("");
      else
        $("#phone").css("background", "rgba(255, 0, 0, 0.2)");
        $("#error_phone").text("неккоректный номер телефона");
    else
      $("#phone").css("background", "white");
      $("#error_phone").text("");

  validate_room = ()->
    if $("#room").val()
      $("#room").css("background", "rgba(0, 255, 0, 0.2)");
      $("#error_room").text("");
    else
      $("#room").css("background", "white");
      $("#error_room").text("");

  validate_step3 = ()->
    val = $("#phone").val()
    if val
      reg = /^[0-9]{11}$/i
      if reg.test(val)
        $("#phone").css("background", "rgba(0, 255, 0, 0.2)");
        $("#error_phone").text("");
      else
        $("#phone").css("background", "rgba(255, 0, 0, 0.2)");
        $("#error_phone").text("неккоректный номер телефона");

  0




