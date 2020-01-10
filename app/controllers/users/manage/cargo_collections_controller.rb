class Users::Manage::CargoCollectionsController < Users::BaseController
    before_action :get_quotation, only: [:update,:update_collection]

     def update
        
        @cargo_collection = CargoCollection.find_by_quotation_id(@quotation.id)
        if @cargo_collection.update(cargo_collections_with_params)
            if @quotation.weight_type == "FCL"
                @cargo_collection.update(status: "Empty Send")
            else
                @cargo_collection.update(status: "On Plan")
            end
            if CargoDeclaration.find_by_quotation_id(@quotation.id).nil?
                CargoDeclaration.create!(quotation_id: @quotation.id)
            end
            respond_to do |format|
                format.html { redirect_to users_manage_shipment_path(@quotation.quotation_id), :flash => {:success => 'Successful Update Cargo Collection.'}}
                format.json { render :json => @quotation }
              end
          else
          format.json { render json: @quotation.errors, status: :unprocessable_entity }
              redirect_to request.referrer
          end
     end

     def update_collection
        if @quotation.weight_type == "FCL"
            @cargo_collection = CargoCollection.find_by_quotation_id(@quotation.id)
            if @cargo_collection.update(status: "Laden Collected")
                respond_to do |format|
                    format.html { redirect_to users_manage_shipment_path(@quotation.quotation_id), :flash => {:success => 'Successful Update Cargo Collection.'}}
                    format.json { render :json => @quotation }
                end
            else
            format.json { render json: @quotation.errors, status: :unprocessable_entity }
                redirect_to request.referrer
            end
        else
            @cargo_collection = CargoCollection.find_by_quotation_id(@quotation.id)
            if @cargo_collection.update(status: "Collected")
                respond_to do |format|
                    format.html { redirect_to users_manage_shipment_path(@quotation.quotation_id), :flash => {:success => 'Successful Update Cargo Collection.'}}
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
 
        @quotation = Quotation.find_by_quotation_id(params[:id])
        
     end

     private
 
        def cargo_collections_with_params
            params.require(:cargo_collection).permit(:haulage,:status,:truck_type,:driver_phone_number,:driver_name,:truck_number,:estimated_collection_date,:file_rot)
        end
  
   
 end