class ConfirmationsController < Devise::ConfirmationsController
  def almost_there
    flash[:notice] = nil
    render layout: "devise_empty"
  end

  protected

  def after_resending_confirmation_instructions_path_for(resource)
    users_almost_there_path
  end

  def after_confirmation_path_for(_resource_name, resource)
    # incoming resource can either be a :user or an :email
    if signed_in?(:user)
      after_sign_in_path_for(resource)
    else
      flash[:notice] += " Please sign in."
      new_session_path(:user)
    end
  end
end
