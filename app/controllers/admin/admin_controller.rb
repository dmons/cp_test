# frozen_string_literal: true

class Admin::AdminController < ApplicationController
  before_action :validate_admin_role!

  private
  def validate_admin_role!
    redirect_to root_path, alert: "Sorry, only admins access granted!" unless is_admin?
  end
end
