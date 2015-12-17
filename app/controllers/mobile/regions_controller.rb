class Mobile::RegionsController < ApplicationController
  before_filter :login_required

  def city
    @city = Shoppe::Region.getCity(params[:province])

    respond_to do |format|
      format.json { render json: @city }
    end
  end

  def district
    @district = Shoppe::Region.getDistrict(params[:city])

    respond_to do |format|
      format.json { render json: @district }
    end
  end

  def getNameByCode
    @name = Shoppe::Region.where(code: params[:code])
  end


  def index
  end
end
