require 'rails_helper'

RSpec.describe Board, type: :model do

  let(:board) { Board.create(title: "Board Name") }

  it { is_expected.to validate_presence_of(:title) }



end
