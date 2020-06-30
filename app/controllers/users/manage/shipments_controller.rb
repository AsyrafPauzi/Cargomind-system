class Users::Manage::ShipmentsController < ApplicationController
  before_action :get_quotation, only: [:show, :update, :destroy, :approved_quotation, :rejected_quotation, :send_quotation,:client_update, :bill_of_lading, :update_bill_of_lading, :view_bill_of_lading, :awb, :update_awb, :view_awb]
  layout 'single_page', :only => [:view_bill_of_lading, :view_awb ]
   def index
    @quotation = Quotation.where(user_id: nil).or(Quotation.where(user_id: current_user.id)).order(created_at: :desc)
   end

   def show
      
   end

   def new
      
   end

   def create
  
      
   end

   def update
   end

   def destroy

    @quotation.destroy
    respond_to do |format|
      format.html { redirect_to users_manage_shipments_path, notice: 'Quotation was successfully destroyed.' }
      format.json { head :no_content }
    end

   end

   def approved_quotation

    if @quotation.update(user_id: current_user.id, status: "approved")
      respond_to do |format|
          format.html { redirect_to users_manage_shipment_path(@quotation.quotation_code), :flash => {:success => 'Successful Create Quotation.'}}
          format.json { render :json => @quotation }
        end
    else
    format.json { render json: @quotation.errors, status: :unprocessable_entity }
        redirect_to request.referrer
    end
      
   end

   def rejected_quotation

    if @quotation.update(user_id: current_user.id, status: "rejected")
      respond_to do |format|
          format.html { redirect_to users_manage_shipment_path(@quotation.quotation_code), :flash => {:success => 'Successful Reject Quotation.'}}
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


  def quotation_params
    params.require(:quotation).permit(:status,:quotation_code, :type_quotation, :to, :date,:attn, :booking_no, :shipper, :consignee,:port_of_loading, :port_of_discharge, :final_destination, :mode_of_shipment,:weight_type, :commodity, :weight_fcl, :weight_air, :weight_lcl)
  end

end