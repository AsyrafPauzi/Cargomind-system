class Users::Manage::ShipmentsController < ApplicationController
  before_action :get_quotation, only: [:show, :update, :destroy, :assign_user, :send_quotation,:client_update, :bill_of_lading, :update_bill_of_lading, :view_bill_of_lading, :awb, :update_awb, :view_awb]
  layout 'single_page', :only => [:view_bill_of_lading, :view_awb ]
   def index
    @quotation = Quotation.where(user_id: nil).or(Quotation.where(user_id: current_user.id)).order(created_at: :desc)
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
              @quotation.update(status: "Draft")
            elsif params[:commit] == "Send RFQ"
              @quotation.update(status: "Request For Quotation")
            elsif params[:commit] == "Confirm Order"
              @quotation.update(status: "Confirm Order")
              if Booking.find_by_quotation_id(@quotation.id).nil?
                Booking.create!(quotation_id: @quotation.id)
            end
              if SlblConfirmation.find_by_quotation_id(@quotation.id).nil?
                SlblConfirmation.create!(quotation_id: @quotation.id)
            end
            if AttachPreAlert.find_by_quotation_id(@quotation.id).nil?
              AttachPreAlert.create!(quotation_id: @quotation.id)
          end
          if CargoDeclaration.find_by_quotation_id(@quotation.id).nil?
            CargoDeclaration.create!(quotation_id: @quotation.id)
        end
        if CargoCollection.find_by_quotation_id(@quotation.id).nil?
          CargoCollection.create!(quotation_id: @quotation.id)
      end
      if Billing.find_by_quotation_id(@quotation.id).nil?
        Billing.create!(quotation_id: @quotation.id)
    end

            end
          format.html { redirect_to clients_path, notice: 'Quotation was successfully created.' }
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
              @quotation.update(status: "Draft")
            elsif params[:commit] == "Send RFQ"
              @quotation.update(status: "Request For Quotation")
            elsif params[:commit] == "Confirm Order"
              @quotation.update(status: "Confirm Order")
              if Booking.find_by_quotation_id(@quotation.id).nil?
                Booking.create!(quotation_id: @quotation.id)
            end
            end
          format.html { redirect_to clients_path, notice: 'Quotation was successfully created.' }
        else
          format.html { render :new }
          format.json { render json: @quotation.errors, status: :unprocessable_entity }
        end
      end
    end
      
   end

   def update
      if params[:commit] == "Save"
       if @quotation.update(quotation_params)
           respond_to do |format|
               format.html { redirect_to request.referrer, :flash => {:success => 'Successful updated Quotation.'}}
               format.json { render :json => @quotation }
           end
       else
        format.json { render json: @quotation.errors, status: :unprocessable_entity }
           redirect_to request.referrer
       end
      elsif params[:commit] == "Send RFQ"
        if @quotation.update(status: "Request For Quotation")
          respond_to do |format|
              format.html { redirect_to request.referrer, :flash => {:success => 'Successful Request For Quotation.'}}
              format.json { render :json => @quotation }
          end
        else
          format.json { render json: @quotation.errors, status: :unprocessable_entity }
            redirect_to request.referrer
        end
      elsif params[:commit] == "Confirm Order"
        if @quotation.update(status: "Confirm Order")
          respond_to do |format|
              format.html { redirect_to request.referrer, :flash => {:success => 'Successful Send Quotation.'}}
              format.json { render :json => @quotation }
          end
        else
          format.json { render json: @quotation.errors, status: :unprocessable_entity }
            redirect_to request.referrer
        end
      elsif params[:commit] == "Request Amendment"
        if @quotation.update(status: "Request Amendment")
          respond_to do |format|
              format.html { redirect_to request.referrer, :flash => {:success => "Successful Request Amendment For Quotation #{@quotation.quotation_id}"}}
              format.json { render :json => @quotation }
          end
        else
          format.json { render json: @quotation.errors, status: :unprocessable_entity }
            redirect_to request.referrer
        end
      end
   end

   def destroy

    @quotation.destroy
    respond_to do |format|
      format.html { redirect_to users_manage_shipments_path, notice: 'Quotation was successfully destroyed.' }
      format.json { head :no_content }
    end

   end

   def assign_user

    if @quotation.update(user_id: current_user.id)
      respond_to do |format|
          format.html { redirect_to users_manage_shipment_path(@quotation.quotation_id), :flash => {:success => 'Successful Assign User To Quotation.'}}
          format.json { render :json => @quotation }
        end
    else
    format.json { render json: @quotation.errors, status: :unprocessable_entity }
        redirect_to request.referrer
    end
      
   end

   def send_quotation
    if params[:commit] == "Final Submit"

      if @quotation.update(file_quotation: params[:quotation][:quotation_file], quotation_status: "Final Confirmed", status: "Confirm Order")
        if @quotation.type_quotation == "Export"
          if Booking.find_by_quotation_id(@quotation.id).nil?
            Booking.create!(quotation_id: @quotation.id)
          end
        else
          if Booking.find_by_quotation_id(@quotation.id).nil?
            Booking.create!(quotation_id: @quotation.id)
        end
          if SlblConfirmation.find_by_quotation_id(@quotation.id).nil?
            SlblConfirmation.create!(quotation_id: @quotation.id)
        end
        if AttachPreAlert.find_by_quotation_id(@quotation.id).nil?
          AttachPreAlert.create!(quotation_id: @quotation.id)
      end
      if CargoDeclaration.find_by_quotation_id(@quotation.id).nil?
        CargoDeclaration.create!(quotation_id: @quotation.id)
    end
    if CargoCollection.find_by_quotation_id(@quotation.id).nil?
      CargoCollection.create!(quotation_id: @quotation.id)
  end
  if Billing.find_by_quotation_id(@quotation.id).nil?
    Billing.create!(quotation_id: @quotation.id)
end
        end

         respond_to do |format|
             format.html { redirect_to users_manage_shipment_path(@quotation.quotation_id), :flash => {:success => 'Successful Send Quotation.'}}
             format.json { render :json => @quotation }
           end
       else
       format.json { render json: @quotation.errors, status: :unprocessable_entity }
           redirect_to request.referrer
       end

    else

      if @quotation.update(file_quotation: params[:quotation][:quotation_file], quotation_status: "Draft", status: "Pending")
        # if Booking.find_by_quotation_id(@quotation.id).nil?
         #  Booking.create!(quotation_id: @quotation.id)
      # end
         respond_to do |format|
             format.html { redirect_to users_manage_shipment_path(@quotation.quotation_id), :flash => {:success => 'Successful Send Quotation.'}}
             format.json { render :json => @quotation }
           end
       else
       format.json { render json: @quotation.errors, status: :unprocessable_entity }
           redirect_to request.referrer
       end

    end
    

   end

   def client_update

    if params[:commit] == "Confirm"
            @quotation = Quotation.find(@quotation.id)
            if @quotation.update(quotation_status: "Confirmed")
                respond_to do |format|
                    format.html { redirect_to clients_manage_shipment_path(@quotation.quotation_id), :flash => {:success => 'Successful Update Feedback Quotation.'}}
                    format.json { render :json => @quotation }
                end
            else
            format.json { render json: @quotation.errors, status: :unprocessable_entity }
                redirect_to request.referrer
            end
    else
    
      if @quotation.update(file_client: params[:quotation][:file_client],remarks: params[:quotation][:remarks], quotation_status: "Client Feedback", status: "Pending")
        # if Booking.find_by_quotation_id(@quotation.id).nil?
         #  Booking.create!(quotation_id: @quotation.id)
      # end
         respond_to do |format|
             format.html { redirect_to clients_manage_shipment_path(@quotation.quotation_id), :flash => {:success => 'Successful Send Quotation.'}}
             format.json { render :json => @quotation }
           end
       else
       format.json { render json: @quotation.errors, status: :unprocessable_entity }
           redirect_to request.referrer
       end

    end
   end

   def booking
      
   end

   def bill_of_lading

   end

   def view_bill_of_lading

    respond_to do |format|
        format.html
        format.pdf do
            render pdf: "BL No. #{@quotation.slbl_confirmation.sibl_no}",
            page_size: 'A4',
            template: "users/manage/shipments/view_bill_of_lading.html.erb",
            layout: "single_page.html.erb",
            orientation: "Portrait",
            lowquality: true,
            zoom: 1,
            dpi: 75
        end
    end

   end

   def awb

   end

   def view_awb

    respond_to do |format|
        format.html
        format.pdf do
            render pdf: "AWB No. #{@quotation.slbl_confirmation.sibl_no}",
            page_size: 'A4',
            template: "users/manage/shipments/view_awb.html.erb",
            layout: "single_page.html.erb",
            orientation: "Portrait",
            lowquality: true,
            zoom: 1,
            dpi: 75
        end
    end

   end

   def update_bill_of_lading
      @SlblConfirmation = SlblConfirmation.find_by_quotation_id(@quotation.id)
      @Quotation = Quotation.find(@quotation.id)
      @Booking = Booking.find_by_quotation_id(@quotation.id)
    if @SlblConfirmation.update(update_client_quotation_params.except(:shipper,:consignee,:vessel,:port_of_loading,:port_of_discharge,:final_destination))
      
      if @Quotation.update(shipper: params[:sibl_confirmation][:shipper],consignee: params[:sibl_confirmation][:consignee],port_of_loading: params[:sibl_confirmation][:port_of_loading],port_of_discharge: params[:sibl_confirmation][:port_of_discharge],final_destination: params[:sibl_confirmation][:final_destination])
        if @Booking.update(vessel: params[:sibl_confirmation][:vessel])
          
        else
          format.json { render json: @quotation.errors, status: :unprocessable_entity }
        redirect_to request.referrer
        end
      else
        format.json { render json: @quotation.errors, status: :unprocessable_entity }
        redirect_to request.referrer
      end
        respond_to do |format|
          format.html { redirect_to users_manage_shipment_path(@quotation.quotation_id), :flash => {:success => 'Successful Update Feedback Quotation.'}}
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

  def quotation_import_params
    params.require(:quotation_import).permit(:quotation_id, :type_quotation, :to, :date,:attn, :booking_no, :shipper, :consignee,:port_of_loading, :port_of_discharge, :final_destination, :mode_of_shipment,:weight_type, :commodity, :client_id, :weight_fcl, :weight_air, :weight_lcl, :quotation_file)
  end

  def quotation_export_params
    params.require(:quotation_export).permit(:quotation_id, :type_quotation, :to, :date,:attn, :booking_no, :shipper, :consignee,:port_of_loading, :port_of_discharge, :final_destination, :mode_of_shipment,:weight_type, :commodity, :client_id, :weight_fcl, :weight_air, :weight_lcl)
  end

  def quotation_params
    params.require(:quotation).permit(:status,:quotation_id, :type_quotation, :to, :date,:attn, :booking_no, :shipper, :consignee,:port_of_loading, :port_of_discharge, :final_destination, :mode_of_shipment,:weight_type, :commodity, :weight_fcl, :weight_air, :weight_lcl)
  end

  def update_client_quotation_params
    params.require(:quotation).permit(:remarks,:file_client)
  end

  def update_client_quotation_params
    params.require(:sibl_confirmation).permit(:shipper,:consignee,:notify_party,:delivery_agent,:vessel,:voyage_no,:combined_transport_onward_carriage,:place_of_receipt,:port_of_loading,:final_destination,:freight_payable_at,:port_of_discharge,:place_of_delivery,:sibl_no,:marks_and_numbers,:no_of_pkgs,:description_of_goods,:gross_weight,:measurement,:container_no,:seal_no,:number_of_packages_in_words,:place_issue,:date_issue,:date,:by)
  end

end