class AdminsController < Admins::BaseController
  before_action :set_admin, only: [:index]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin
      @admin = current_admin
    end


end
