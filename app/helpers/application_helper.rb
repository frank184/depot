module ApplicationHelper

  def hidden_div_if(condition, attributes={}, &block)
    if condition
      attributes["style"] = "display: none"
    end
    content_tag "div", attributes, &block
  end

  def notice_html_safe
    "<p>#{notice}</p>".html_safe if notice
  end

  def current_user
    User.find(session[:user_id])
  rescue ActiveRecord::RecordNotFound
    nil
  end

end
