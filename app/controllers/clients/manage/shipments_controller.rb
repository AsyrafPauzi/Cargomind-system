class Clients::Manage::ShipmentsController < Clients::BaseController
    before_action :get_quotation, only: [:show, :update, :destroy]
     def index
             @quotation = Quotation.where(client_id: current_client)
     end
 
     def show
     end
 
     def new
      @quotation = Quotation.new
     end
 
     def create
        @quotation = Quotation.new(quotation_params)
        respond_to do |format|
          if @quotation.save
            format.html { redirect_to clients_path, notice: 'Quotation was successfully created.' }
          else
            format.html { render :new }
            format.json { render json: @quotation.errors, status: :unprocessable_entity }
          end
      end
        
     end
 
     def update
        if params[:commit] == "Save"
         if @quotation.update(params[:quotation][:mode_of_shipment])
             respond_to do |format|
                 format.html { redirect_to request.referrer, :flash => {:success => 'Successful updated Quotation.'}}
                 format.json { render :json => @quotation }
             end
         else
             flash[:danger] = @company.errors.full_messages.first
             redirect_to request.referrer
         end
        end
     end
 
     def destroy

      @quotation.destroy
      respond_to do |format|
        format.html { redirect_to clients_path, notice: 'Quotation was successfully destroyed.' }
        format.json { head :no_content }
      end

     end

     private
 
     def get_quotation
 
            @quotation = Quotation.find_by_quotation_code(params[:id])
        
     end

     private
 
    def quotation_params
      params.require(:quotation).permit(:client_id, :quotation_code, :remarks, :mode_of_shipment, :mode_of_transport, :incoterm, :currency, :collection_company_name, :collection_address, :collection_pic, :collection_no_tel, :port_of_loading_port, :port_of_loading_state, :port_of_loading_country, :port_of_destination_port, :port_of_destination_state, :port_of_destination_country, :deliver_company_name, :deliver_address, :deliver_pic, :deliver_no_tel, :cargo_type, :cargo_type_msds, :cargo_type_commodity, :cargo_details, :others_warehouse, :others_insurance, :others_cargo_value)
      end
 
 end
 