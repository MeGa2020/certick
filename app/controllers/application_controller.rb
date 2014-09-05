class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # before_filter :charge_current_user, :except => [:logout]

  layout :layout

  def logout
    logger.info "logout - init"

    self.current_user = nil
    redirect_to root_path

    logger.info "logout - done"
  end

  def current_user
    session[:current_user_id]
  end

  def current_user=(user)
    session[:current_user_id] = user
  end

  protected
  def authenticate_user!
    redirect_to root_path unless current_user.token
  end

  def eventick
    Eventick::API.new
  end
  private
  def is_logged
    logger.info "check if user is logged."
    logger.info "redirect to certified index if user logged." if current_user and is_a? SessionsController
  end

  def layout
    # only turn it off for login pages:
    is_a?(SessionsController) || is_a?(GenerateController)  ? "welcome" : "application"
    # or turn layout off for every devise controller:
  end

  def require_login
  #   logger.info "check if controller need login."
  #
  #   if !is_a?(SessionsController) && !is_a?(GenerateController)
  #     logger.info "is not a sessions controler."
  #
  #     logger.info "redirect to root due to current user is nil." unless current_user
  #     redirect_to root_path unless current_user
  #   end
  #
  #   # redirect_to certifieds_path if current_user and is_a? SessionsController
  end

  # def charge_current_user
  #   @current_user = current_user
  # end
end
