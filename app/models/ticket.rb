class Ticket < ActiveRecord::Base

  validates :name, presence: true, uniqueness: { :case_sensitive => false }

  belongs_to :board

  # enum status: %w(backlog current_sprint in_progress done)   #[:backlog, :current_sprint, :in_progress, :done]
  enum status: { backlog: 0, current_sprint: 1, in_progress: 2, done: 3 }


  include AASM
  aasm column: :status, enum: true do
    state :backlog, :initial => true
    state :current_sprint
    state :in_progress
    state :done

    event :ready do
      transitions from: :backlog, to: :current_sprint
    end

    event :cancel do
      transitions from: :current_sprint, to: :backlog
    end

    event :start do
      transitions from: :current_sprint, to: :in_progress
    end

    event :stop do
      transitions from: :in_progress, to: :current_sprint
    end

    event :complete do
      transitions from: :in_progress, to: :done
    end

    event :restart do
      transitions from: :done, to: :in_progress
    end
  end


  # def update_ticket_status(params)
  #   case params[:status]
  #     when 'ready'
  #       self.ready!
  #     when 'cancel'
  #       self.cancel!
  #     when 'start'
  #       self.start!
  #     when 'stop'
  #       self.stop!
  #     when 'complete'
  #       self.complete!
  #     when 'restart'
  #       self.restart!
  #   end
  # end

end
