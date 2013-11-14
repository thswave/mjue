class UsersController < ApplicationController
  skip_before_filter :authenticate_user!
  before_filter :find_registration

  private
    def find_registration
      @registration = Registration.find params[:registration_id]
    end
end
