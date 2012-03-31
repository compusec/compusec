module User::RegisterHelper
  def register_text_field(name, head, mark = false, help = "")
    color = (flash[name])? ("rgba(255, 0, 0, 0.2)"): ("white")
    message = flash[name] if flash[name]
    head = (mark)? ("#{head} *"): (head)
    content_tag(:tr,
      content_tag(:td, content_tag(:label, head, :class => "label_text")) <<
      content_tag(:td, text_field_tag(name, session[name], :class => "text_field", :style => "background: #{color}", :placeholder => help))  <<
      content_tag(:td, message, :class => "error", :id => "error_#{name}")
    )
  end
  def register_password_field(name, head, mark = false, help = "")
    color = (flash[name])? ("rgba(255, 0, 0, 0.2)"): ("white")
    message = flash[name] if flash[name]
    head = (mark)? ("#{head} *"): (head)
    content_tag(:tr,
      content_tag(:td, content_tag(:label, head, :class => "label_text")) <<
      content_tag(:td, password_field_tag(name, session[name], :class => "text_field", :style => "background: #{color}", :placeholder => help))  <<
      content_tag(:td, message, :class => "error", :id => "error_#{name}")
    )
  end
end

