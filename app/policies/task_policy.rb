class TaskPolicy < ApplicationPolicy
  def create?
    record.list.user == user
  end

  def show?
    record.list.user == user
  end

  def update?
    record.list.user == user
  end

  def destroy?
    record.list.user == user
  end

  def toggle_done?
    record.list.user == user
  end

  def completed?
    record.list.user == user
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      # Now we resolve tasks by checking the associated list's user
      scope.joins(:list).where(lists: { user: user })
    end
  end
end
