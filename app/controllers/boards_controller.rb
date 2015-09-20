class BoardsController < ApplicationController
  before_action :set_board, only: [:destroy]

  def index
    @boards = Board.all
    @desc_boards = @boards.sort_by(&:created_at).reverse
  end

  def show
    @board = Board.find(params[:id])
  end

  def new
    @board = Board.new
    @tickets = @board.tickets
  end

  def create
    @board = Board.new(board_params)
    if @board.save
      redirect_to boards_path #board_path(@board)
    else
      flash.now[:errors] = @board.errors.full_messages.join(", ")
      render :new
    end
  end

  def destroy
    @board.destroy!
    redirect_to boards_path
  end

  private

  def board_params
    params.require(:board).permit(:title)
  end

  def set_board
    @board = Board.find(params[:id])
  end

end
