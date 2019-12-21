class ClientsController < Clients::BaseController
    before_action :set_user, only: [:index]
  
    # GET /users
    # GET /users.json
    def index
      @quotation = Quotation.where(client_id: current_client).limit(10).order(created_at: :desc)
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_user
        @client = current_client
      end
  
  
  end
  