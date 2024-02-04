class ApplicationController < ActionController::Base

  private
  def authenticate_user!
    redirect_to root_path, alert: 'Must be logged in!' unless user_signed_in?
  end

  def current_user
    Current.user ||= auth_from_session
  end
  helper_method :current_user

  def auth_from_session
    User.find_by(id: session[:user_id])
  end

  def user_signed_in?
    current_user.present?
  end
  helper_method :user_signed_in?

  def is_admin?
    current_user.is_admin?
  end
  helper_method :is_admin?

  def login(user)
    Current.user = user
    reset_session
    session[:user_id] = user.id
  end

  def logout(user)
    Current.user = nil
    reset_session
  end
end
