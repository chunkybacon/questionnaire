class ApplicationController < ActionController::Base
  protect_from_forgery

  inherit_resources
  include InheritedResources::DSL

  before_filter :setup_page_if_exists

  private

  def setup_page_if_exists
    return unless params.key?(:page)
    page = params[:page].to_i rescue 1
    page = 1 if page < 0 
    params[:page] = page
    nil
  end

end
