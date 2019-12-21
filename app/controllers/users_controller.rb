class UsersController < Users::BaseController
  before_action :set_user, only: [:index]

  # GET /users
  # GET /users.json
  def index
    @quotation_1 = Quotation.where(status: "Request Amendment").limit(5).order(created_at: :desc)
    @quotation_2 = Quotation.where(status: "Confirm Order").limit(5).order(created_at: :desc)
    @quotation_3 = Quotation.where(status: "Request For Quotation").limit(5).order(created_at: :desc)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = current_user
    end


end
