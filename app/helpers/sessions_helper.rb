module SessionsHelper

  def show_flash
    "<div class='container'>#{display_success_alert}#{display_error_alert}</div>".html_safe
  end

  def display_success_alert
    if flash[:success].present?
      html = ['<div class="alert alert-success" role="alert">',
                "<strong>#{flash[:success]}</strong>",
              '</div>']
      html.join
    end
  end

  def display_error_alert
    if flash[:error].present?
      html = ['<div class="alert alert-danger" role="alert">',
                "<strong>#{flash[:error]}</strong>",
              '</div>']
      html.join
    end
  end

end
