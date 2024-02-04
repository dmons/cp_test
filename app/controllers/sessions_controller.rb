class SessionsController < ApplicationController
  def new
  end
  def create
    if user = User.authenticate_by(name: params[:name], password: params[:password])
      login user
      redirect_to root_path, notice: 'Login successfull!'
    else
      flash[:alert] = 'Invalid credentials'
      render :new, status: :unprocessable_entity
    end
  end
  def destroy
    logout current_user
    redirect_to root_path, notice: 'Logged out!'
  end
end
