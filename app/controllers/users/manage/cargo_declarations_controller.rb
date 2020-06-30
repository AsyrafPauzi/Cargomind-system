class Users::Manage::CargoDeclarationsController < ApplicationController
    before_action :authenticate_user!, only: [:update]
    before_action :get_quotation, only: [:update,:client_update]

     def update
        if params[:commit] == "Submit Final Form"
            @cargo_declaration = CargoDeclaration.find_by_quotation_code(@quotation.id)
            if @cargo_declaration.update(cargo_declarations_with_params)
                @cargo_declaration.update(status: "Cargo Declaration Confirmed")
                if @quotation.type_quotation == "Export"
                    if SlblConfirmation.find_by_quotation_code(@quotation.id).nil?
                        SlblConfirmation.create!(quotation_code: @quotation.id)
                    end
                else
                    if CargoCollection.find_by_quotation_code(@quotation.id).nil?
                        CargoCollection.create!(quotation_code: @quotation.id)
                    end
                end
                      
                respond_to do |format|
                    format.html { redirect_to users_manage_shipment_path(@quotation.quotation_code), :flash => {:success => 'Successful Update Final Cargo Declaration.'}}
                    format.json { render :json => @quotation }
                end
            else
            format.json { render json: @quotation.errors, status: :unprocessable_entity }
                redirect_to request.referrer
            end
        else
            @cargo_declaration = CargoDeclaration.find_by_quotation_code(@quotation.id)
            if @cargo_declaration.update(cargo_declarations_with_params)
                @cargo_declaration.update(status: "Draft")
                respond_to do |format|
                    format.html { redirect_to users_manage_shipment_path(@quotation.quotation_code), :flash => {:success => 'Successful Update Cargo Declaration.'}}
                    format.json { render :json => @quotation }
                end
            else
            format.json { render json: @quotation.errors, status: :unprocessable_entity }
                redirect_to request.referrer
            end
        end
     end

     def client_update
        if params[:commit] == "Submit"
            @cargo_declaration = CargoDeclaration.find_by_quotation_code(@quotation.id)
            if @cargo_declaration.update(cargo_declarations_with_params)
                @cargo_declaration.update(status: "Rejected")
                respond_to do |format|
                    format.html { redirect_to clients_manage_shipment_path(@quotation.quotation_code), :flash => {:success => 'Successful Update Feedback Cargo Declaration.'}}
                    format.json { render :json => @quotation }
                end
            else
            format.json { render json: @quotation.errors, status: :unprocessable_entity }
                redirect_to request.referrer
            end
        elsif params[:commit] == "Confirm"
            @cargo_declaration = CargoDeclaration.find_by_quotation_code(@quotation.id)
            if @cargo_declaration.update(status: "Confirmed")
                respond_to do |format|
                    format.html { redirect_to clients_manage_shipment_path(@quotation.quotation_code), :flash => {:success => 'Successful Update Feedback Cargo Declaration.'}}
                    format.json { render :json => @quotation }
                end
            else
            format.json { render json: @quotation.errors, status: :unprocessable_entity }
                redirect_to request.referrer
            end
        end
     end
 
     private
 
     def get_quotation
 
        @quotation = Quotation.find_by_quotation_code(params[:id])
        
     end

     private
 
        def cargo_declarations_with_params
            params.require(:cargo_declaration).permit(:file_declaration,:file_client_draft,:remarks)
        end
  
   
 end