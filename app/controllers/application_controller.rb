class ApplicationController < ActionController::Base
  def show_html_builder
    @tokens = params.permit(:tokens)[:tokens]
    html = "<div></div>"
    render '/html_builder'
  end
end
