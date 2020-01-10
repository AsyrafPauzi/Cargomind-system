class Users::Manage::FlightDepartsController < ApplicationController
    before_action :authenticate_user!, only: [:update]
    before_action :get_quotation, only: [:update]

     def update
            @flight_depart = FlightDepart.find_by_quotation_id(@quotation.id)
            if @flight_depart.update(status: "Confirmed Flight Depart")
                if AttachPreAlert.find_by_quotation_id(@quotation.id).nil?
                    AttachPreAlert.create!(quotation_id: @quotation.id)
                end
                respond_to do |format|
                    format.html { redirect_to users_manage_shipment_path(@quotation.quotation_id), :flash => {:success => 'Successful Update Flight Depart.'}}
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
 
        def flight_departs_with_params
            params.require(:flight_depart).permit()
        end
  
   
 end