class Users::Manage::AttachPreAlertsController < ApplicationController
    before_action :authenticate_user!, only: [:update]
    before_action :get_quotation, only: [:update]

     def update
            @attach_pre_alert = AttachPreAlert.find_by_quotation_id(@quotation.id)
            if @attach_pre_alert.update(attach_pre_alerts_with_params)
                @attach_pre_alert.update(status: "Attach Pre Alert Confirmed")
                if @quotation.type_quotation == "Export"
                    if Billing.find_by_quotation_id(@quotation.id).nil?
                        Billing.create!(quotation_id: @quotation.id)
                    end
                else
                    if CargoDeclaration.find_by_quotation_id(@quotation.id).nil?
                        CargoDeclaration.create!(quotation_id: @quotation.id)
                    end
                end
                
                respond_to do |format|
                    format.html { redirect_to users_manage_shipment_path(@quotation.quotation_id), :flash => {:success => 'Successful Update Attach Pre Alert.'}}
                    format.json { render :json => @quotation }
                end
            else
            format.json { render json: @quotation.errors, status: :unprocessable_entity }
                redirect_to request.referrer
            end
     end
     
     private
 
     def get_quotation
 
        @quotation = Quotation.find_by_quotation_id(params[:id])
        
     end

     private
 
        def attach_pre_alerts_with_params
            params.require(:attach_pre_alert).permit(:file_attach_pre_alert)
        end
  
   
 end