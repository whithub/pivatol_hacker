require 'rails_helper'

RSpec.describe Ticket, type: :model do

  let(:ticket) { Ticket.create(name: "Ticket title", description: "Ticket description", status: 0) }

  it { is_expected.to validate_presence_of(:name) }
  it { should belong_to(:board) }

  it "is invalid without a title" do
    ticket.name = ""
    expect(ticket).to_not be_valid
  end

  it "is valid without a description, description can be blank" do
    ticket.description = ""
    expect(ticket).to be_valid
  end

  it "is valid without a status; defaults to backlog" do
    #TODO need to test enum... backlog

    ticket_2 = Ticket.create(name: "Ticket title #2")
    expect(ticket_2).to be_valid
    expect(ticket_2.status).to eq(0)
  end




end
