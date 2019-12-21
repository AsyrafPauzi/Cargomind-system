class Clients::Manage::ShipmentsController < Clients::BaseController
    before_action :get_quotation, only: [:show, :update, :destroy]
     def index
             @quotation = Quotation.where(client_id: current_client)
     end
 
     def show
     end
 
     def new
        
     end
 
     def create
      if params[:quotation_import].present?
        @quotation = Quotation.new(quotation_import_params)
        respond_to do |format|
          if @quotation.save
              if params[:commit] == "Draft"
                @quotation.update_attributes(status: "Draft")
              elsif params[:commit] == "Send RFQ"
                @quotation.update_attributes(status: "Request For Quotation")
              elsif params[:commit] == "Confirm Order"
                @quotation.update_attributes(status: "Confirm Order")
              end
            format.html { redirect_to clients_manage_shipments_path, notice: 'Quotation was successfully created.' }
          else
            format.html { render :new }
            format.json { render json: @quotation.errors, status: :unprocessable_entity }
          end
        end
      elsif params[:quotation_export].present?
        @quotation = Quotation.new(quotation_export_params)
        respond_to do |format|
          if @quotation.save
              if params[:commit] == "Draft"
                @quotation.update_attributes(status: "Draft")
              elsif params[:commit] == "Send RFQ"
                @quotation.update_attributes(status: "Request For Quotation")
              elsif params[:commit] == "Confirm Order"
                @quotation.update_attributes(status: "Confirm Order")
              end
            format.html { redirect_to clients_manage_shipments_path, notice: 'Quotation was successfully created.' }
          else
            format.html { render :new }
            format.json { render json: @quotation.errors, status: :unprocessable_entity }
          end
        end
      end
        
     end
 
     def update
        if params[:commit] == "Save"
         if @quotation.update_attributes(quotation_params)
             respond_to do |format|
                 format.html { redirect_to request.referrer, :flash => {:success => 'Successful updated Quotation.'}}
                 format.json { render :json => @quotation }
             end
         else
             flash[:danger] = @company.errors.full_messages.first
             redirect_to request.referrer
         end
        elsif params[:commit] == "Send RFQ"
          if @quotation.update(status: "Request For Quotation")
            respond_to do |format|
                format.html { redirect_to request.referrer, :flash => {:success => 'Successful Request For Quotation.'}}
                format.json { render :json => @quotation }
            end
          else
              flash[:danger] = @company.errors.full_messages.first
              redirect_to request.referrer
          end
        elsif params[:commit] == "Confirm Order"
          if @quotation.update(status: "Confirm Order")
            respond_to do |format|
                format.html { redirect_to request.referrer, :flash => {:success => 'Successful Send Quotation.'}}
                format.json { render :json => @quotation }
            end
          else
              flash[:danger] = @company.errors.full_messages.first
              redirect_to request.referrer
          end
        elsif params[:commit] == "Request Amendment"
          if @quotation.update(status: "Request Amendment")
            respond_to do |format|
                format.html { redirect_to request.referrer, :flash => {:success => "Successful Request Amendment For Quotation #{@quotation.quotation_id}"}}
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
        format.html { redirect_to clients_manage_shipments_path, notice: 'Quotation was successfully destroyed.' }
        format.json { head :no_content }
      end

     end

     def booking
        
     end

     def bill_of_lading

     end
 
     private
 
     def get_quotation
 
            @quotation = Quotation.find_by_quotation_id(params[:id])
        
     end

     private
 
    def quotation_import_params
      params.require(:quotation_import).permit(:quotation_id, :type_quotation, :to, :date,:attn, :booking_no, :shipper, :consignee,:port_of_loading, :port_of_discharge, :final_destination, :cargo_type,:weight_type, :commodity, :client_id, :weight_fcl, :weight_air, :weight_lcl)
    end

    def quotation_export_params
      params.require(:quotation_export).permit(:quotation_id, :type_quotation, :to, :date,:attn, :booking_no, :shipper, :consignee,:port_of_loading, :port_of_discharge, :final_destination, :cargo_type,:weight_type, :commodity, :client_id, :weight_fcl, :weight_air, :weight_lcl)
    end

    def quotation_params
      params.require(:quotation).permit(:status,:quotation_id, :type_quotation, :to, :date,:attn, :booking_no, :shipper, :consignee,:port_of_loading, :port_of_discharge, :final_destination, :cargo_type,:weight_type, :commodity, :weight_fcl, :weight_air, :weight_lcl)
    end
 
 end