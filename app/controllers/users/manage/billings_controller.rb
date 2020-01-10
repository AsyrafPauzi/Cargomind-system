class Users::Manage::BillingsController < ApplicationController
    before_action :authenticate_user!, only: [:update]
    before_action :get_quotation, only: [:update]

     def update
            @billing = Billing.find_by_quotation_id(@quotation.id)
            if @billing.update(status: "Confirmed Billing")
                if Insurance.find_by_quotation_id(@quotation.id).nil?
                    Insurance.create!(quotation_id: @quotation.id)
                end
                respond_to do |format|
                    format.html { redirect_to users_manage_shipment_path(@quotation.quotation_id), :flash => {:success => 'Successful Update Billing.'}}
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
 
        def billings_with_params
            params.require(:billing).permit()
        end
  
   
 end