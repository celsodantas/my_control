class ApplicationController < ActionController::Base
  
  protect_from_forgery
  
  before_filter :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    Rails.logger.debug "Access denied on #{exception.action} #{exception.subject.inspect}!"
    flash[:error] = "Access denied."
    redirect_to root_url
  end
  
  protected
  
  def standardise_numbers
    unless params[controller_name.singularize][:amount].nil?
      params[controller_name.singularize][:amount].sub!(/\./,'')
      params[controller_name.singularize][:amount].sub!(/,/, '.') 
    end
  end
  
end
