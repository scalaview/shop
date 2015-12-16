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