class Admins::Manage::ShipmentsController < Admins::BaseController
    before_action :get_shipment, only: [:destroy]
     def index
             
     end
 
     def show
 
     end
 
     def new
        
     end
 
     def create
     # @company = Company.new(company_params)
     #respond_to do |format|
     #  if @company.save
     #    current_user.update_attributes(company_id: @company.id)
     #    format.html { redirect_to request.referrer, notice: 'Company was successfully created.' }
     #    format.json { render :show, status: :created, location: @question }
     #  else
     #    format.html { render :new }
     #    format.json { render json: @company.errors, status: :unprocessable_entity }
     #  end
     #end
     end
 
     def update
         #if @company.update_attributes(company_params)
         #    respond_to do |format|
         #        format.html { redirect_to request.referrer, :flash => {:success => 'Successful updated company.'}}
         #        format.json { render :json => @company }
         #    end
         #else
         #    flash[:danger] = @company.errors.full_messages.first
         #    redirect_to request.referrer
         #end
     end
 
     def destroy

        @quotation.destroy
        respond_to do |format|
          format.html { redirect_to admins_path, notice: 'Quotation was successfully destroyed.' }
          format.json { head :no_content }
        end

     end
 
     private
 
     def get_shipment
 
        @quotation = Quotation.find_by_quotation_code(params[:id])
        
     end
 
     def shipment_params
         params.require(:shipment).permit()
     end
 
 end