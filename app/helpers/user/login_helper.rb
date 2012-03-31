#coding: utf-8
module User::LoginHelper
  def login_text_field(name, head, help = "")
    color = (flash[name])? ("rgba(255, 0, 0, 0.2)"): ("white")
    message = flash[name] if flash[name]
    content_tag(:tr,
      content_tag(:td, content_tag(:label, head, :class => "label_text")) <<
      content_tag(:td, text_field_tag(name, params[name], :class => "text_field", :style => "background: #{color}", :placeholder => help))  <<
      content_tag(:td, message, :style => "color: rgba(255, 0, 0, 0.8);", :id => "error_#{name}")
    )
  end
  def login_password_field(name, head, help = "")
    color = (flash[name])? ("rgba(255, 0, 0, 0.2)"): ("white")
    message = flash[name] if flash[name]
    content_tag(:tr,
      content_tag(:td, content_tag(:label, head, :class => "label_text")) <<
      content_tag(:td, password_field_tag(name, params[name], :class => "text_field", :style => "background: #{color}", :placeholder => help))  <<
      content_tag(:td, message, :style => "color: rgba(255, 0, 0, 0.8);", :id => "error_#{name}")
    )
  end
end
