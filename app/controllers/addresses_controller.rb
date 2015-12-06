class AddressesController < ApplicationController
  layout  "shopping_cart"
  # before_filter :login_required
  before_filter :init, :only => [:edit, :update, :set_default, :destroy]

  def index
    @addresses = current_customer.addresses
  end

  def new
    @address = current_customer.build_address
  end

  def create

  end

  def edit

  end

  def update

  end

  def set_default
    @address = current_customer.addresses.find params[:id]
  end

  def destroy

  end

  private

  def init
    @address = current_customer.addresses.find params[:id]
  end

end
