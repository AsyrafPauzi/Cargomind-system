class Users::Manage::SlblConfirmationsController < ApplicationController
    before_action :authenticate_user!, only: [:update]
    before_action :get_quotation, only: [:update,:client_update]

     def update
        if params[:commit] == "Submit Final AWB"
            @slbl_confirmation = SlblConfirmation.find_by_quotation_code(@quotation.id)
            if @slbl_confirmation.update(slbl_confirmations_with_params)
                @slbl_confirmation.update(status: "SL/BL Confirmed")
                if @quotation.weight_type == "LCL"
                    if VesselDepart.find_by_quotation_code(@quotation.id).nil?
                        VesselDepart.create!(quotation_code: @quotation.id)
                    end
                else
                    if AttachPreAlert.find_by_quotation_code(@quotation.id).nil?
                        AttachPreAlert.create!(quotation_code: @quotation.id)
                    end
                end
                respond_to do |format|
                    format.html { redirect_to users_manage_shipment_path(@quotation.quotation_code), :flash => {:success => 'Successful Update SL/BL Confirmation.'}}
                    format.json { render :json => @quotation }
                end
            else
            format.json { render json: @quotation.errors, status: :unprocessable_entity }
                redirect_to request.referrer
            end
        elsif params[:commit] == "Submit Final BL"
                @slbl_confirmation = SlblConfirmation.find_by_quotation_code(@quotation.id)
                if @slbl_confirmation.update(slbl_confirmations_with_params)
                    @slbl_confirmation.update(status: "SL/BL Confirmed")
                    if @quotation.weight_type == "LCL"
                        if VesselDepart.find_by_quotation_code(@quotation.id).nil?
                            VesselDepart.create!(quotation_code: @quotation.id)
                        end
                    else
                        if AttachPreAlert.find_by_quotation_code(@quotation.id).nil?
                            AttachPreAlert.create!(quotation_code: @quotation.id)
                        end
                    end
                    respond_to do |format|
                        format.html { redirect_to users_manage_shipment_path(@quotation.quotation_code), :flash => {:success => 'Successful Update SL/BL Confirmation.'}}
                        format.json { render :json => @quotation }
                    end
                else
                format.json { render json: @quotation.errors, status: :unprocessable_entity }
                    redirect_to request.referrer
                end
        else
            @slbl_confirmation = SlblConfirmation.find_by_quotation_code(@quotation.id)
            if @slbl_confirmation.update(slbl_confirmations_with_params)
                @slbl_confirmation.update(status: "Draft")
                respond_to do |format|
                    format.html { redirect_to users_manage_shipment_path(@quotation.quotation_code), :flash => {:success => 'Successful Update SL/BL Confirmation.'}}
                    format.json { render :json => @quotation }
                end
            else
            format.json { render json: @quotation.errors, status: :unprocessable_entity }
                redirect_to request.referrer
            end
        end
     end

     def client_update
        if params[:commit] == "Submit"
            @slbl_confirmation = SlblConfirmation.find_by_quotation_code(@quotation.id)
            if @slbl_confirmation.update(slbl_confirmations_with_params)
                @slbl_confirmation.update(status: "Rejected")
                respond_to do |format|
                    format.html { redirect_to clients_manage_shipment_path(@quotation.quotation_code), :flash => {:success => 'Successful Update Feedback SL/BL Confirmation.'}}
                    format.json { render :json => @quotation }
                end
            else
            format.json { render json: @quotation.errors, status: :unprocessable_entity }
                redirect_to request.referrer
            end
        elsif params[:commit] == "Confirm"
            @slbl_confirmation = SlblConfirmation.find_by_quotation_code(@quotation.id)
            if @slbl_confirmation.update(status: "Confirmed")
                respond_to do |format|
                    format.html { redirect_to clients_manage_shipment_path(@quotation.quotation_code), :flash => {:success => 'Successful Update Feedback SL/BL Confirmation.'}}
                    format.json { render :json => @quotation }
                end
            else
            format.json { render json: @quotation.errors, status: :unprocessable_entity }
                redirect_to request.referrer
            end
        end
     end
 
     private
 
     def get_quotation
 
        @quotation = Quotation.find_by_quotation_code(params[:id])
        
     end

     private
 
        def slbl_confirmations_with_params
            params.require(:slbl_confirmation).permit(:file_confirmation,:file_client_draft,:remarks)
        end
  
   
 end