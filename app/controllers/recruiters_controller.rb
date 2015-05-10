class RecruitersController < ApplicationController
  before_action :set_recruiter, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :check_user, only: [:edit, :update, :destroy]
  before_action :check_connections, only: [:new, :create]

  def complete_recruiter
    @user = current_user
  end

  def index
    @recruiters = Recruiter.all
  end

  # GET /recruiters/1
  # GET /recruiters/1.json
  def show
    @recruiter = Recruiter.find(params[:id])
  end

  # GET /recruiters/new
  def new
    @disable_nav = true
    if current_user.recruiter.nil?
      @recruiter = Recruiter.new
      @disable_nav = true
    else
      flash[:alert] = "Dude, you can only create one recruiter."
      redirect_to profiles_path
    end
  end

  # GET /recruiters/1/edit
  def edit
  end

  # POST /recruiters
  # POST /recruiters.json
  def create
    @recruiter = Recruiter.new(recruiter_params)
    @recruiter.user_id = current_user.id

    # Store friendly recruiter URI
    # current_user.recruiter_uri = getUniqueURI(current_user) 
    current_user.save

    respond_to do |format|
      if @recruiter.save
        format.html { redirect_to profiles_path, notice: 'You have successfully signed up.' }
        format.json { render :show, status: :created, location: @recruiter }
      else
        format.html { render :new }
        format.json { render json: @recruiter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recruiters/1
  # PATCH/PUT /recruiters/1.json
  def update
    respond_to do |format|
      if @recruiter.update(recruiter_params)
        format.html { redirect_to @recruiter, notice: 'recruiter was successfully updated.' }
        format.json { render :show, status: :ok, location: @recruiter }
      else
        format.html { render :edit }
        format.json { render json: @recruiter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recruiters/1
  # DELETE /recruiters/1.json
  def destroy
    @recruiter.destroy
    respond_to do |format|
      format.html { redirect_to recruiters_url, notice: 'recruiter was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recruiter
        @recruiter = Recruiter.find(params[:id])
        # @user = User.find(params[:id])
    end
      
    def check_connections
      if current_user.connections.present?
        redirect_to profiles_path, alert: "Sorry, you are not a recruiter"
      end
    end

    def check_user
      if current_user != @recruiter.user
        redirect_to root_url, alert: "Sorry, this does not belong to you"
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recruiter_params
      params.require(:recruiter).permit(:title, :company_location, :company_name, :phone_number)
    end

    # def getUniqueURI(user)
    #   pin = current_user.id
    #   "#{user.first_name}-#{user.last_name}-#{pin}"
    # end
end
