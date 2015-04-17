class AdminUsersController < ApplicationController

  layout "admin"

  before_action :confirm_logged_in

  def index
  	@admin_users = AdminUser.all.sorted
  end

  def new
  	@admin_user = AdminUser.new
  end

  def create
  	@admin_user = AdminUser.new( admin_user_params )

  	if @admin_user.save
  		flash[:notice] = "User created successfully."
  		redirect_to(:action => 'index')
  	else
  		flash[:notice] = "User created failed."
  		render(:action => 'news')
  	end

  end

  def edit
  	@admin_user = AdminUser.find( params[:id] )
  end

  def update
 	@admin_user = AdminUser.find( params[:id] )

 	if @admin_user.update_attributes( admin_user_params )
 		# if user updated successfully. 
 		flash[:notice] = "User updated successfully."
 		redirect_to(:action => 'index')
 	else
 		# render edit page. 
 		flash[:notice] = "User unable to update."
 		render(:action => 'edit')
 	end
  	
  end

  def delete
  	@admin_user = AdminUser.find( params[:id] )
  end

  def destroy
  	@admin_user 	= AdminUser.find( params[:id] ).destroy
  	flash[:notice]  = "User deleted successfully."
  	redirect_to(:action => 'index')
  end

  private
    def admin_user_params
      # same as using "params[:subject]", except that it:
      # - raises an error if :subject is not present
      # - allows listed attributes to be mass-assigned.
      params.require(:admin_user).permit(:first_name, :last_name, :email, :username, :password)
      
    end
end
