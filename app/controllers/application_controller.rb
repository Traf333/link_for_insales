class ApplicationController < ActionController::Base
  protect_from_forgery

  def redirect_back
    session[:return_to] ||= request.referer
    redirect_to session.delete(:return_to)
  end
end
