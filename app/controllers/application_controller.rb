class ApplicationController < ActionController::Base
  def show_html_builder
    respond_to do |format|
      format.html { render '/html_builder' }
      format.js { render '/html_builder' }
    end
  end
end
