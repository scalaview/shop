class AreasController < ApplicationController
	def show
	  data = Areas.list(params[:id])
	  render json: data, layout: nil
	end

	def index
	end
end
