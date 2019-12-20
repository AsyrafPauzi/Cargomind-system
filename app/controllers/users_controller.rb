class UsersController < Users::BaseController
  before_action :set_user, only: [:index]

  # GET /users
  # GET /users.json
  def index
    @quotation = Quotation.where(user_id: current_user).limit(10).order(created_at: :desc)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = current_user
    end


end
