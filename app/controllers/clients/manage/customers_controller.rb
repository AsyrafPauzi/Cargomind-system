class Clients::Manage::CustomersController < Clients::BaseController
    before_action :get_customer, only: [:show, :update, :destroy]
     def index
        @customer = Customer.where(client_id: current_client.id).order(created_at: :desc)
     end
 
     def show
            
     end
 
     def new
        
     end
 
     def create
        @customer = Customer.new(customers_params)
        respond_to do |format|
          if @customer.save
            format.html { redirect_to clients_manage_customers_path, notice: 'Customer was successfully created.' }
          else
            format.html { render :new }
            format.json { render json: @customer.errors, status: :unprocessable_entity }
          end
        end
     end
 
     def update

            if @customer.update_attributes(customers_params)
                respond_to do |format|
                    format.html { redirect_to request.referrer, :flash => {:success => 'Successful updated Customer Information.'}}
                    format.json { render :json => @customer }
                end
            else
                flash[:danger] = @customer.errors.full_messages.first
                redirect_to request.referrer
            end
        
     end
 
     def destroy

        @customer.destroy
        respond_to do |format|
          format.html { redirect_to clients_manage_customers_path, notice: 'Customer was successfully destroyed.' }
          format.json { head :no_content }
        end

     end

     private
 
     def get_customer
 
        @customer = Customer.find(params[:id])
        
     end

     private
 
    def customers_params
      params.require(:customer).permit(:client_id, :no_tel, :address, :company, :name)
    end
 
 end