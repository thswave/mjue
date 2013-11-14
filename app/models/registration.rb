class Registration < ActiveRecord::Base
  attr_accessor :username, :password

  attr_accessible :username, :password, :step

  after_initialize :initialize_with_defaults
  before_create :retrieve_transaction_id

  def initialize_with_defaults
    self.step ||= 1
  end

  def retrieve_transaction_id
    begin
      user = User.find_or_new_verified_user username: username, password: password,
        organization: VERIFIER_ORGANIZATION
    rescue Exception => e
      puts e.backtrace
      return false
    end

    self.transaction_id = user.transaction_id

    true
  end

  def proceed
    update_attribute :step, step + 1
  end

  def best_or_worst
    step < 3 ? 'best' : 'worst'
  end

  def best?
    best_or_worst == 'best'
  end

  def worst?
    best_or_worst == 'worst'
  end

  def current_step
    if step < 2
      :new
    elsif step < 3
      :welcome
    elsif step < 4
      :assess
    else
      :finished
    end
  end
end
