class ProfilesController < ApplicationController
  
  # GET /users/:user_id/profile/new
  def new
    @profile = Profile.new
  end
  
  # POST /users/:user_id/profile
  def create
    #
    @user = User.find( params[:user_id])
    #
    #.build_<> - from ActiveRecord documentation. build_
    # used to establish a connection between tables.
    #
    @profile = @user.build_profile( profile_params )
    if @profile.save
      flash[:success] = "Profile Updated"
      redirect_to user_path(params[:user_id])
    else
      render action: :new
    end
  end
  
  private
  
  def profile_params
    # strong assignment, white-listing what's allowed to pass through the form from the user.
    params.require(:profile).permit(:first_name, :last_name, :job_title, :phone_number, :contact_email, :description)
  end
  
end
