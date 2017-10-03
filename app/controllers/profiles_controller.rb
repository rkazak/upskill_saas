class ProfilesController < ApplicationController
  
  # GET /users/:user_id/profile/new
  def new
    @profile = Profile.new
  end

end
