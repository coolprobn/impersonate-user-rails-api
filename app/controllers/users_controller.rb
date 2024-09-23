class UsersController < ApplicationController
  include RackSession

  def index
    users = User.all

    render(json: users)
  end

  def impersonate
    # TODO: return you can't impersonate yourself if impersonating user is the same as current user
    user = User.find(params[:id])

    impersonate_user(user)

    true_user.update!(impersonating_user_id: user.id)

    render(json: current_user)
  end

  def stop_impersonating
    stop_impersonating_user

    true_user.update!(impersonating_user_id: nil)

    render(json: current_user)
  end
end
