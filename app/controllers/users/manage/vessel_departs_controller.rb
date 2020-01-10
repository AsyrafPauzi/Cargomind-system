class Users::Manage::VesselDepartsController < ApplicationController
    before_action :authenticate_user!, only: [:update]
    before_action :get_quotation, only: [:update]

     def update
            @vessel_depart = VesselDepart.find_by_quotation_id(@quotation.id)
            if @vessel_depart.update(status: "Confirmed Vessel Depart")
                if AttachPreAlert.find_by_quotation_id(@quotation.id).nil?
                    AttachPreAlert.create!(quotation_id: @quotation.id)
                end
                respond_to do |format|
                    format.html { redirect_to users_manage_shipment_path(@quotation.quotation_id), :flash => {:success => 'Successful Update Vessel Depart.'}}
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
 
        def vessel_departs_with_params
            params.require(:vessel_depart).permit()
        end
  
   
 end