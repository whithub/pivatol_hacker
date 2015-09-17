class BoardsController < ApplicationController
  def index
    @boards = Board.all
  end

  def show
    @board = Board.find_by(title: params[:id])
  end

  def new
    @board = Board.new
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

  private

  def board_params
    params.require(:board).permit(:title)
  end

end
