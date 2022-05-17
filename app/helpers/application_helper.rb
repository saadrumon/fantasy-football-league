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
end
