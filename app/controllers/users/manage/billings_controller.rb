class Users::Manage::BillingsController < ApplicationController
    before_action :authenticate_user!, only: [:update]
    before_action :get_quotation, only: [:update]

     def update
            @billing = Billing.find_by_quotation_code(@quotation.id)
            if @billing.update(billings_with_params.merge(status: "Billing Confirmed"))
                if BillingDetail.find_by_billing_id(@billing.id).nil?
                    params[:billing][:title].each_with_index  do |data, index|

                        profit = params[:billing][:profit]
                        cost = params[:billing][:cost]
                        bill = params[:billing][:bill]
                        title = params[:billing][:title]

                        BillingDetail.create!(billing_id: @billing.id,title: title[index], cost: cost[index], bill: bill[index], profit: profit[index])

                    end
                else    
                        BillingDetail.where(billing_id: @billing.id).destroy_all
                        params[:billing][:title].each_with_index  do |data, index|
                        profit = params[:billing][:profit]
                        cost = params[:billing][:cost]
                        bill = params[:billing][:bill]
                        title = params[:billing][:title]

                        BillingDetail.create!(billing_id: @billing.id,title: title[index], cost: cost[index], bill: bill[index], profit: profit[index])

                    end
                end
                if @quotation.type_quotation == "Export"
                    if Insurance.find_by_quotation_code(@quotation.id).nil?
                        Insurance.create!(quotation_code: @quotation.id)
                    end
                else
                    if Insurance.find_by_quotation_code(@quotation.id).nil?
                        Insurance.create!(quotation_code: @quotation.id)
                    end
                end
                
                respond_to do |format|
                    format.html { redirect_to users_manage_shipment_path(@quotation.quotation_code), :flash => {:success => 'Successful Update Billing.'}}
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
 
        def billings_with_params
            params.require(:billing).permit(:invoice)
        end
  
   
 end