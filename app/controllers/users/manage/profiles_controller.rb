class Users::Manage::ProfilesController < Users::BaseController
    before_action :get_profile, only: [:index,:show, :update]
     def index
          
     end
 
     def show
            
     end
 
     def new
        
     end
 
     def create
        
     end
 
     def update
         if @user.update_attributes(users_params)
            bypass_sign_in @user
             respond_to do |format|
                 format.html { redirect_to request.referrer, :flash => {:success => 'Successful updated User Profile.'}}
                 format.json { render :json => @user }
             end
         else
             flash[:danger] = @user.errors.full_messages.first
             redirect_to request.referrer
         end
     end
 
     def destroy
     end

 


     private
 
     def get_profile
 
        @user = User.find(current_user.id)
        
     end

     private
 
    def users_params
      params.require(:user).permit(:password, :password_confirmation,:email,:name,:address,:no_tel)
    end
 
 end