class Clients::Manage::ProfilesController < Clients::BaseController
    before_action :get_profile, only: [:index, :update]
     def index
          
     end
  
     def update

        if params[:client][:password].blank? && params[:client][:password_confirmation].blank?
            if @client.update_attributes(clients_without_params)
                bypass_sign_in @client
                respond_to do |format|
                    format.html { redirect_to request.referrer, :flash => {:success => 'Successful updated Client Profile.'}}
                    format.json { render :json => @client }
                end
            else
                flash[:danger] = @client.errors.full_messages.first
                redirect_to request.referrer
            end
        else
            if @client.update_attributes(clients_with_params)
                bypass_sign_in @client
                respond_to do |format|
                    format.html { redirect_to request.referrer, :flash => {:success => 'Successful updated Client Profile.'}}
                    format.json { render :json => @client }
                end
            else
                flash[:danger] = @client.errors.full_messages.first
                redirect_to request.referrer
            end
        end
     end
 
     private
 
     def get_profile
 
        @client = current_client
        
     end

     private
 
    def clients_with_params
      params.require(:client).permit(:password, :password_confirmation,:email,:name,:address,:no_tel)
    end

    def clients_without_params
        params.require(:client).permit(:email,:name,:address,:no_tel)
      end
 
 end