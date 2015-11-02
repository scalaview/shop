class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def login_required
    unless logged_in?
      redirect_to login_path
    end
  end

  def logged_in?
    current_customer.is_a?(Shoppe::Customer)
  end

  def current_customer
    @current_customer ||= login_from_session || false
  end

  def login_from_session
    if session[:customer_id]
      @current_customer = Shoppe::Customer.find_by_id(session[:customer_id])
    end
  end

  helper_method :current_customer, :logged_in?
end
