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
    expect(ticket_2.status).to eq('backlog')
  end

  describe 'status' do
    subject { Ticket.new }

    it { is_expected.to respond_to(:status) }

    describe ':backlog' do
      it 'is the initial state' do
        expect(subject.backlog?).to eql(true)
      end

      it 'can be transitioned to :current_sprint' do
        expect { subject.ready }.to change(subject, :current_sprint?).from(false).to(true)
      end

      it 'cannot be transitioned to :in_progress' do
        expect { subject.start }.to raise_error(AASM::InvalidTransition)
      end

      it 'cannot be transitioned to :done' do
        expect { subject.complete }.to raise_error(AASM::InvalidTransition)
      end
    end

    describe ':current_sprint' do
      before { subject.status = :current_sprint }

      it 'can be transitioned back to :backlog' do
        expect { subject.cancel }.to change(subject, :backlog?).from(false).to(true)
      end

      it 'can be transitioned to :in_progress' do
        expect { subject.start }.to change(subject, :in_progress?).from(false).to(true)
      end

      it 'cannot be transitioned to :done' do
        expect { subject.complete }.to raise_error(AASM::InvalidTransition)
      end
    end

    describe ':in_progress' do
      before { subject.status = :in_progress }

      it 'cannot be transitioned back to :backlog' do
        expect { subject.cancel }.to raise_error(AASM::InvalidTransition)
      end

      it 'can be transitioned back to :current_sprint' do
        expect { subject.stop }.to change(subject, :current_sprint?).from(false).to(true)
      end

      it 'can be transitioned to :done' do
        expect { subject.complete }.to change(subject, :done?).from(false).to(true)
      end
    end

    describe ':done' do
      before { subject.status = :done }

      it 'cannot be transitioned back to :backlog' do
        expect { subject.cancel }.to raise_error(AASM::InvalidTransition)
      end

      it 'cannot be transitioned back to :current_sprint' do
        expect { subject.stop }.to raise_error(AASM::InvalidTransition)
      end

      it 'can be transitioned back to :in_progress' do
        expect { subject.restart }.to change(subject, :in_progress?).from(false).to(true)
      end
    end
  end


end
