class Users::Manage::CargoCollectionsController < Users::BaseController
    before_action :get_quotation, only: [:update,:update_collection, :update_collection_replanned]

     def update
        
        @cargo_collection = CargoCollection.find_by_quotation_code(@quotation.id)
        if @cargo_collection.update(cargo_collections_with_params)
            if @quotation.type_quotation == "Import"
                if params[:commit] == "Re-Planned"
                    @cargo_collection.update(status: "Re-Planned")
                else
                    @cargo_collection.update(status: "Planned")
                end
                
            else
            if @quotation.weight_type == "FCL"
                @cargo_collection.update(status: "Empty Send")
            else
                @cargo_collection.update(status: "On Plan")
            end
        end
            if @quotation.type_quotation == "Export"
                if CargoDeclaration.find_by_quotation_code(@quotation.id).nil?
                    CargoDeclaration.create!(quotation_code: @quotation.id)
                end
            else
                if Billing.find_by_quotation_code(@quotation.id).nil?
                    Billing.create!(quotation_code: @quotation.id)
                end
            end
            
            respond_to do |format|
                format.html { redirect_to users_manage_shipment_path(@quotation.quotation_code), :flash => {:success => 'Successful Update Cargo Collection.'}}
                format.json { render :json => @quotation }
              end
          else
          format.json { render json: @quotation.errors, status: :unprocessable_entity }
              redirect_to request.referrer
          end
     end

     def update_collection

        if @quotation.type_quotation == "Import"

            @cargo_collection = CargoCollection.find_by_quotation_code(@quotation.id)
            if @cargo_collection.update(status: "Deliver")
                respond_to do |format|
                    format.html { redirect_to users_manage_shipment_path(@quotation.quotation_code), :flash => {:success => 'Successful Update Cargo Delivery.'}}
                    format.json { render :json => @quotation }
                end
            else
            format.json { render json: @quotation.errors, status: :unprocessable_entity }
                redirect_to request.referrer
            end

        else
            if @quotation.weight_type == "FCL"
                @cargo_collection = CargoCollection.find_by_quotation_code(@quotation.id)
                if @cargo_collection.update(status: "Laden Collected")
                    respond_to do |format|
                        format.html { redirect_to users_manage_shipment_path(@quotation.quotation_code), :flash => {:success => 'Successful Update Cargo Delivery.'}}
                        format.json { render :json => @quotation }
                    end
                else
                format.json { render json: @quotation.errors, status: :unprocessable_entity }
                    redirect_to request.referrer
                end
            else
                @cargo_collection = CargoCollection.find_by_quotation_code(@quotation.id)
                if @cargo_collection.update(status: "Collected")
                    respond_to do |format|
                        format.html { redirect_to users_manage_shipment_path(@quotation.quotation_code), :flash => {:success => 'Successful Update Cargo Delivery.'}}
                        format.json { render :json => @quotation }
                    end
                else
                    format.json { render json: @quotation.errors, status: :unprocessable_entity }
                    redirect_to request.referrer
                end
            end
        end


     end

     def update_collection_replanned

       
                @cargo_collection = CargoCollection.find_by_quotation_code(@quotation.id)
                if @cargo_collection.update(status: "Re-Planned")
                    respond_to do |format|
                        format.html { redirect_to users_manage_shipment_path(@quotation.quotation_code), :flash => {:success => 'Successful Update Cargo Collection.'}}
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
 
        def cargo_collections_with_params
            params.require(:cargo_collection).permit(:haulage,:status,:truck_type,:driver_phone_number,:driver_name,:truck_number,:estimated_collection_date,:file_rot,:lcl_remarks)
        end
  
   
 end