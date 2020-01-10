class Users::Manage::BookingsController < Users::BaseController
    before_action :get_quotation, only: [:update]

     def update
        @booking = Booking.find_by_quotation_id(@quotation.id)
        if @booking.update(bookings_with_params)
            if CargoCollection.find_by_quotation_id(@quotation.id).nil?
                CargoCollection.create!(quotation_id: @quotation.id)
            end
            respond_to do |format|
                format.html { redirect_to users_manage_shipment_path(@quotation.quotation_id), :flash => {:success => 'Successful Update Booking Confirmation.'}}
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
 
        def bookings_with_params
            params.require(:booking).permit(:vessel,:flight_number,:booking_number,:file_booking).merge(status: "Booking Confirmation")
        end
  
   
 end