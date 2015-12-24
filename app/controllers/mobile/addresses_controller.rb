class Mobile::AddressesController < ApplicationController
  layout  "mobile"
  # before_filter :login_required
  before_filter :init, :only => [:edit, :update, :set_default, :destroy]

  def index
    @addresses = current_customer.addresses
  end

  def manage
    @addresses = current_customer.addresses
    render  "manage"
  end

  def show

  end

  def new
    @address = current_customer.addresses.build
  end

  def create
    @address = current_customer.addresses.build(safe_params)
    if current_customer.addresses.count == 0
      @address.default = true
    end
    @address.country_id = 1
    if @address.save
      redirect_to action: "manage", :flash => {:notice => "新增地址成功"}
    else
      render action: "new"
    end
  end

  def edit
    @address = current_customer.addresses.find params[:id]
  end

  def update
    if @address.update(safe_params)
      flash[:notice] = "修改地址成功"
      redirect_to action: "manage"
    else
      flash[:error] = @address.errors.full_messages.join("; ")
      render action: "edit"
    end
  end

  def set_default
    @address = current_customer.addresses.find params[:id]

  end

  def destroy
    @address.destroy
    redirect_to action: "manage", :flash => {:notice => "删除成功"}
  end

  def reset_default
    if self.default?
      Shoppe::Address.update_all 'default=0', ['customer_id = ? and id <> ?', self.customer_id, self.id]
    end

  end

  private

  def init
    @address = current_customer.addresses.find params[:id]
  end

  def safe_params
    params[:address].permit(:receiver_name, :phone, :province, :city, :area, :location, :postcode, :default)
  end

end
