class TicketsController < ApplicationController
  before_action :load_board
  before_action :set_ticket, only: [:show, :edit, :update]

  def index
  end

  def show
  end

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = @board.tickets.new(ticket_params)

    if @ticket.save
      redirect_to board_path(@board), notice: "Ticket Created"
    else
      flash.now[:errors] = @ticket.errors.full_messages.join(", ")
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def ticket_params
    params.require(:ticket).permit(:name, :description, :status)
  end

  def load_board
    @board = Board.find(params[:board_id])
  end

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end
end
