class Users::Manage::InsurancesController < ApplicationController
    before_action :authenticate_user!, only: [:update]
    before_action :get_quotation, only: [:update]

     def update
            @insurance = Insurance.find_by_quotation_code(@quotation.id)
            if @insurance.update(insurances_with_params.merge(status: "Insurance Confirmed"))
                respond_to do |format|
                    format.html { redirect_to users_manage_shipment_path(@quotation.quotation_code), :flash => {:success => 'Successful Update Insurance.'}}
                    format.json { render :json => @quotation }
                end
            else
            format.json { render json: @quotation.errors, status: :unprocessable_entity }
                redirect_to request.referrer
            end
     end

     private
 
     def get_quotation
 
        @quotation = Quotation.find_by_quotation_code(params[:id])
        
     end

     private
 
        def insurances_with_params
            params.require(:insurance).permit(:policy)
        end
  
   
 end