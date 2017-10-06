class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :only_current_user
  
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
  
  # GET /users/:user_id/profile/edit(.:format)
  def edit
    @user = User.find( params[:user_id])
    @profile = @user.profile
  end
  
  # PUT / PATCH /users/:user_id/profile(.:format) 
  def update
    # reterieve the current user's resources
    @user = User.find( params[:user_id] )
    # reterieve the current user's profile
    @profile = @user.profile
    # mass update any edited profile parameters and save (update)
    if @profile.update_attributes( profile_params )
      flash[:success] = "Profile Updated"
      redirect_to user_path(params[:user_id])
    else
      render action: :edit
    end
  end
  
  private
  
  def profile_params
    # strong assignment, white-listing what's allowed to pass through the form from the user.
    params.require(:profile).permit(:first_name, :last_name, :avatar, :job_title, :phone_number, :contact_email, :description)
  end
  
  def only_current_user
    @user = User.find( params[:user_id])
    redirect_to(root_url) unless @user == current_user
  end
  
end
