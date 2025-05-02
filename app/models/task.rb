class Task < ApplicationRecord
  belongs_to :user

  def mark_as_done!
    self.update(done: !done)
  end
end
