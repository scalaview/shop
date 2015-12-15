class Mobile::SessionsController < ApplicationController

  def login
    @customer = Shoppe::Customer.new({ :email => params[:email] })
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
    @customer = Shoppe::Customer.new({ :email => params[:email], :first_name => params[:first_name], :last_name => params[:last_name],
      :mobile => params[:mobile] })
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
      redirect_to register_path(:params => { :backurl => params[:backurl], :email => customer_params[:email],
        :first_name => customer_params[:first_name], :last_name => customer_params[:last_name], :phone => customer_params[:phone] })
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
