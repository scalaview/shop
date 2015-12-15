class Mobile::UserInfoController < ApplicationController
  layout  "mobile"

  before_filter :login_required

  def show
    render  "user_info"
  end
end