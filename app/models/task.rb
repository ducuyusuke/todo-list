class Task < ApplicationRecord
  belongs_to :list

  before_create :set_initial_position
  validates :name, presence: true

  def mark_as_done!
    self.update(done: !done)
  end

  private

  def set_initial_position
    if self.position.nil?
      last_position = Task.where(list: self.list).maximum(:position) || 0
      self.position = last_position + 1
    end
  end
end
