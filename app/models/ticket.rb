class Ticket < ActiveRecord::Base
  # include AASM
  validates :name, presence: true, uniqueness: { :case_sensitive => false }

  belongs_to :board

  # enum status: %w(backlog, current_sprint, in_progress, done)   #[:backlog, :current_sprint, :in_progress, :done]
  #
  # aasm :column => :status, :enum => true do
  #   state :backlog, :initial => true
  #   state :current_sprint
  #   state :in_progress
  #   state :done
  #
  #   # event :ticket_started do
  #   #   transitions from: :backlog, to: :current_sprint
  #   # end
  #
  #   event :work_in_progress do
  #     transitions from: :backlog, to: :current_sprint
  #     transitions from: :current_sprint, to: :backlog || :in_progress
  #     transitions from: :in_progress, to: :current_sprint || :done
  #     transitions from: :done, to: :in_progress
  #   end
  #
  #   # event :complete do
  #   #   transitions from: :in_progress, to: :current_sprint || :done
  #   # end
  #   #
  #   # event :really_done? do
  #   #   transitions from: :done, to: :in_progress
  #   # end
  # end
  #
  # # def ticket_status
  # #   if status == 'backlog'
  # #     self.status = 'current_sprint'
  # #   elsif  status == 'current_sprint'
  # #
  # #
  # #   end
  # # end


end
