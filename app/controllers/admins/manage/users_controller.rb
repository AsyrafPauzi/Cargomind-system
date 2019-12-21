class Admins::Manage::UsersController < Admins::BaseController
    before_action :get_user, only: [:show, :update, :destroy]
     def index
             @user = User.all.order(created_at: :desc)
     end
 
     def show
 
     end
 
     def new
        
     end
 
     def create
      @user = User.new(users_params)
     respond_to do |format|
       if @user.save
         format.html { redirect_to admins_manage_users_path, notice: 'User was successfully created.' }
       else
         format.html { render :new }
         format.json { render json: @user.errors, status: :unprocessable_entity }
      end
     end
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
 
     def destroy

        @user.destroy
        respond_to do |format|
          format.html { redirect_to admins_manage_users_path, notice: 'User was successfully destroyed.' }
          format.json { head :no_content }
        end

     end
 
     private
 
     def get_user
 
            @user = User.find(params[:id])
        
     end
 
     private
 
        def users_with_params
            params.require(:user).permit(:password, :password_confirmation,:email,:name,:no_tel)
        end

        def users_params
            params.require(:user).permit(:email, :password, :password_confirmation)
        end
  
        def users_without_params
            params.require(:user).permit(:email,:name,:no_tel)
        end
 
 end