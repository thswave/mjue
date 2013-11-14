class MainController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:teaser]

  def teaser
    render layout: 'welcome'
  end

  def me
    @user = current_user
  end
end
