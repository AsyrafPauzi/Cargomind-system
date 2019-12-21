class Admins::Manage::ClientsController < Admins::BaseController
    before_action :get_client, only: [:show, :update, :destroy]
    def index
            @client = Client.all.order(created_at: :desc)
    end

    def show

    end

    def new
       
    end

    def create
     @client = Client.new(clients_params)
    respond_to do |format|
      if @client.save
        format.html { redirect_to admins_manage_clients_path, notice: 'User was successfully created.' }
      else
        format.html { render :new }
        format.json { render json: @client.errors, status: :unprocessable_entity }
     end
    end
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

    def destroy

       @client.destroy
       respond_to do |format|
         format.html { redirect_to admins_manage_clients_path, notice: 'Client was successfully destroyed.' }
         format.json { head :no_content }
       end

    end

    private

    def get_client

           @client = Client.find(params[:id])
       
    end

    private

       def clients_with_params
           params.require(:client).permit(:password, :password_confirmation,:email,:address,:name,:no_tel)
       end

       def clients_params
           params.require(:client).permit(:email, :password, :password_confirmation)
       end
 
       def clients_without_params
           params.require(:client).permit(:email,:name,:no_tel,:address)
       end

end