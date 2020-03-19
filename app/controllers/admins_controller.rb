class AdminsController < Admins::BaseController
  before_action :set_admin, only: [:index]

  # GET /users
  # GET /users.json
  def index
    @user = User.all.limit(5).order(created_at: :desc)
    @client = Client.all.limit(5).order(created_at: :desc)
    @quotation = Quotation.all.order(created_at: :desc)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin
      @admin = current_admin
    end
end
