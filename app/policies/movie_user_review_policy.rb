class MovieUserReviewPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      return scope.all if user.role == 'admin'

      scope.where(user_id: user.id)
    end
  end

  def update?
    return true if user.role == 'admin'

    record.user_id == user.id
  end
end
