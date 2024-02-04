# frozen_string_literal: true

class Admin::TicketsController < Admin::AdminController
  include Sift
  before_action :find_ticket, only: [:edit,:update, :destroy]
  before_action :force_current_user, only: :update
  filter_on :status, type: :string

  def index
    @stats = Ticket.status_stats
    @tickets = filtrate Ticket.all.page(params[:page])
  end

  def edit
  end

  def update
    @comment = Comment.build(ticket: @ticket)
    if @ticket.update(ticket_params)
      redirect_to edit_admin_ticket_path(@ticket)
    else
      render :edit
    end
  end

  def destroy
   @ticket.destroy
   redirect_to admin_tickets_path, alert: "Ticket ##{@ticket.id} was successfully deleted"
  end

  private
  def find_ticket
    @ticket=Ticket.find(params[:id])
  end
  def ticket_params
    params.require(:ticket).permit(
      :status,
      comments_attributes: [:content, :user_id])
  end
  def force_current_user
    params[:ticket][:comments_attributes]&.each do |comment_attributes|
      comment_attributes[1].merge!(:user_id => current_user.id)
    end
  end
end
