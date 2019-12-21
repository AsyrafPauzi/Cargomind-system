class Users::Manage::ProfilesController < Users::BaseController
    before_action :get_profile, only: [:index, :update]
     def index
          
     end
 
     def update

        if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
            if @user.update_attributes(users_without_params)
                bypass_sign_in @user
                respond_to do |format|
                    format.html { redirect_to request.referrer, :flash => {:success => 'Successful updated User Profile.'}}
                    format.json { render :json => @user }
                end
            else
                flash[:danger] = @user.errors.full_messages.first
                redirect_to request.referrer
            end
        else
            if @user.update_attributes(users_with_params)
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
     end
 
     private
 
     def get_profile
 
        @user = current_user
        
     end

     private
 
        def users_with_params
            params.require(:user).permit(:password, :password_confirmation,:email,:name,:no_tel)
        end
  
        def users_without_params
            params.require(:user).permit(:email,:name,:no_tel)
        end
   
 end