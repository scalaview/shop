class SessionsController < ApplicationController
  def login
    @customer = Shoppe::Customer.new(params[:customer])
  end

  def sign_in
    @customer = Shoppe::Customer.authenticate(customer_params[:email], customer_params[:password])
    if @customer
      session[:customer_id] = @customer.id
      if params[:backurl].present?

      else
        redirect_to :root
      end
    else
      flash[:error] = I18n.t('sign_in.email_or_password_error')
      redirect_to sign_in_path(:params => { :backurl => params[:backurl], :customer => customer_params_withou_password })
    end
  end

  def register
    @customer = Shoppe::Customer.new(params[:customer])
  end

  def sign_up
    @customer = Shoppe::Customer.new(customer_params)
    if @customer.save
      if params[:backurl].present?

      else
        redirect_to :root
      end
    else
      flash[:error] = I18n.t('sign_in.email_or_password_error')
      redirect_to register_path(:params => { :backurl => params[:backurl], :customer => customer_params_withou_password })
    end
  end

  def contact

  end

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :email, :password, :phone, :password_confirmation)
  end

  def customer_params_withou_password
    params[:customer].permit(:first_name, :last_name, :email, :phone)
  end

end
