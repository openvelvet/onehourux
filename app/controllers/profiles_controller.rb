class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :check_user, only: [:edit, :update, :destroy]
  before_action :check_connections, only: [:new, :create]

  def complete_profile
    @user = current_user
  end

  def index
    @profiles = Profile.all
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
  end

  # GET /profiles/new
  def new
    if current_user.profile.nil?
      @profile = Profile.new
      @disable_nav = true
    else
      flash[:alert] = "Dude, you can only create one profile."
      redirect_to profile_path(current_user.profile)
    end
  end

  # GET /profiles/1/edit
  def edit
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(profile_params)
    @profile.user_id = current_user.id

    # Store friendly profile URI
    current_user.profile_uri = getUniqueURI(current_user) 
    current_user.save

    respond_to do |format|
      if @profile.save
        format.html { redirect_to complete_profile_path, notice: 'Profile was successfully created.' }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      if params[:id].to_i != 0
        @profile = Profile.find(params[:id])
        # @user = User.find(params[:id])
      else
        @user = User.find_by_profile_uri(params[:id])
      end
    end
      

    def check_user
      if current_user != @profile.user
        redirect_to root_url, alert: "Sorry, this does not belong to you"
      end
    end

    def check_connections
      if current_user.connections.nil?
        redirect_to root_url, alert: "Sorry, you are a recruiter not a user"
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:years_of_experience, :experience_level, :price, :field)
    end

    def getUniqueURI(user)
      pin = current_user.id
      "#{user.first_name}-#{user.last_name}-#{pin}"
    end
end
