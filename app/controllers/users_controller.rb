class UsersController < Users::BaseController
  before_action :set_user, only: [:index,:post_status,:delete_status]

  # GET /users
  # GET /users.json
  def index
    @quotation_2 = Quotation.where(user_id: nil).or(Quotation.where(user_id: current_user.id)).order(created_at: :desc)
  end

  def post_status

    @user_status = UserStatus.new(user_status_with_params)
    respond_to do |format|
      if @user_status.save
        format.html { redirect_to request.referrer, notice: 'User Status was successfully created.' }
      else
        format.html { render :new }
        format.json { render json: @quotation.errors, status: :unprocessable_entity }
      end
    end


  end

  def delete_status
    
    @user = UserStatus.find(params[:id])

    @user.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer, notice: 'Quotation was successfully destroyed.' }
      format.json { head :no_content }
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = current_user
    end

    private
 
    def user_status_with_params
        params.require(:user_status).permit(:user_id,:description,:status,:quotation_id)
    end

end
