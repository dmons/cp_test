# frozen_string_literal: true

class MainController < ApplicationController
  def index
    @ticket = TicketMock.new current_user: current_user
  end
  def new
    @ticket = TicketMock.new ticket_params
  end
  def create
    # debugger
    @ticket = TicketMock.new ticket_params

    if @ticket.valid?
      @ticket.save
      redirect_to root_path, notice: "Ticket saved!"
    else
      render :new, alert: "Fill all requested data!"
    end
  end

  private
  def ticket_params
    params.require(:ticket_mock).permit(
      :requester_name,
      :requester_email,
      :subject,
      :status,
      :content
    )
  end
end
