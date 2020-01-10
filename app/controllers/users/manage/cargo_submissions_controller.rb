class Users::Manage::CargoSubmissionsController < ApplicationController
    before_action :authenticate_user!, only: [:update]
    before_action :get_quotation, only: [:update]

     def update
            @cargo_submissions = CargoSubmission.find_by_quotation_id(@quotation.id)
            if @cargo_submissions.update(status: "Confirmed Cargo Submission")
                if FlightDepart.find_by_quotation_id(@quotation.id).nil?
                    FlightDepart.create!(quotation_id: @quotation.id)
                end
                respond_to do |format|
                    format.html { redirect_to users_manage_shipment_path(@quotation.quotation_id), :flash => {:success => 'Successful Update Cargo Submission.'}}
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
 
        def cargo_submissions_with_params
            params.require(:cargo_submission).permit()
        end
  
   
 end