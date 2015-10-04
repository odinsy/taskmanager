class MainController < ApplicationController

  skip_before_filter :require_login
  layout 'main'

  def index
  end

end
