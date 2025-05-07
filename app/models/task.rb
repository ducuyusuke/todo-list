class Task < ApplicationRecord
  belongs_to :user

  before_create :set_initial_position
  validates :name, :due_date, presence: true

  def mark_as_done!
    self.update(done: !done)
  end

  private

  def set_initial_position
    if self.position.nil?
      last_position = Task.where(user: self.user).maximum(:position) || 0
      self.position = last_position + 1
    end
  end
end
