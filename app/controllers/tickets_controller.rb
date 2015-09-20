class TicketsController < ApplicationController
  before_action :load_board
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]

  def index
  end

  def show
  end

  def new
    @ticket = Ticket.new
  end

  def status
    @statuses = Tickets.statuses
  end

  def create
    @ticket = @board.tickets.new(ticket_params)

    if @ticket.save
      redirect_to board_path(@board), notice: "Ticket Created"
    else
      redirect_to board_path(@board), notice: @ticket.errors.full_messages.join(", ")
    end
  end

  def edit
  end

  def update
    if @ticket.update_attributes(ticket_params)
      redirect_to board_path(@board), notice: 'Ticket was successfully updated.'
    else
      flash.now[:errors] = @idea.errors.full_messages.join(", ")
      render :edit
    end
  end

  def destroy
    @ticket.destroy
    redirect_to board_path(@board)
  end

  def ready
    set_ticket
    @ticket.ready!
    redirect_to board_path(@board), notice: "Ticket '#{@ticket.name}' is now in Current Sprint."
    # @ticker.status = 'current_print'
  end

  def cancel
    set_ticket
    @ticket.cancel!
    redirect_to board_path(@board), notice: "Ticket '#{@ticket.name}' has been cancelled."
  end

  def start
    set_ticket
    @ticket.start!
    redirect_to board_path(@board), notice: "Ticket '#{@ticket.name}' is now In Progress."
    # if @ticket.save
    #   redirect_to board_path(@board), notice: "Ticket '#{@ticket.name}' has been started."
    # else
    #   error
    # end
  end

  def stop
    set_ticket
    @ticket.stop!
    redirect_to board_path(@board), notice: "Ticket '#{@ticket.name}' is back in Current Sprint."
  end

  def complete
    set_ticket
    @ticket.complete!
    redirect_to board_path(@board), notice: "Ticket '#{@ticket.name}' is now Done."
  end

  def restart
    set_ticket
    @ticket.restart!
    redirect_to board_path(@board), notice: "Ticket '#{@ticket.name}' is back In Progress."
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
