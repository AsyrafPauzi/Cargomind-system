class UsersController < Users::BaseController
  before_action :set_user, only: [:index]

  # GET /users
  # GET /users.json
  def index
    @quotation_1 = Quotation.where(status: "Request Amendment").where(user_id: nil).or(Quotation.where(status: "Request Amendment").where(user_id: current_user.id)).limit(5).order(created_at: :desc)
    @quotation_2 = Quotation.where(status: "Confirm Order").where(user_id: nil).or(Quotation.where(status: "Confirm Order").where(user_id: current_user.id)).limit(5).order(created_at: :desc)
    @quotation_3 = Quotation.where(status: "Request For Quotation").where(user_id: nil).or(Quotation.where(status: "Request For Quotation").where(user_id: current_user.id)).limit(5).order(created_at: :desc)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = current_user
    end


end
