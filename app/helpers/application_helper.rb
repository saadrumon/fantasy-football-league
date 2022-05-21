module ApplicationHelper
  def bootstrap_class_for(flash_type)
    bootstrap_alert_class = {
      success: 'alert-success',
      error: 'alert-danger',
      warning: 'alert-warning',
      notice: 'alert-success'
    }
    bootstrap_alert_class[flash_type.to_sym]
  end

  def render_status_badge(object)
    output = ''
    if object.running?
      output += "<span class='badge badge-success'>RUNNING</span>"
    elsif object.ended?
      output += "<span class='badge badge-info'>ENDED</span>"
    end

    output.html_safe
  end
end
