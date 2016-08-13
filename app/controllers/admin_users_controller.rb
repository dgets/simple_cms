class AdminUsersController < ApplicationController

  layout "admin"

  before_action :confirm_logged_in

  def index

    @ausers = AdminUser.sorted

  end

  def new

    @admin_user = AdminUser.new(:first_name => "John", :last_name => "Smith")

  end

  def create

    @admin_user = AdminUser.new(adminuser_params)

    if @admin_user.save
      flash[:notice] = "Admin User created successfully."
      redirect_to(:action => 'index')
    else
      render('new')
    end

  end

  def edit

    @admin_user = AdminUser.find(params[:id])

  end

  def update

    @admin_user = AdminUser.find(params[:id])

    if @admin_user.update_attributes(adminuser_params)
      flash[:notice] = "Admin User record updated successfully."
      redirect_to(:action => 'index')
    else
      render('edit')
    end

  end

  def delete

    @admin_user = AdminUser.find(params[:id])

  end

  def destroy

    @admin_user = AdminUser.find(params[:id]).destroy

    flash[:notice] = 
	"#{@admin_user.last_name}, #{@admin_user.first_name} destroyed..."
    redirect_to(:action => 'index')

  end

  private

  def adminuser_params
    params.require(:admin_user).permit(:first_name, :last_name, :email, 
	:username, :password)
  end

end
