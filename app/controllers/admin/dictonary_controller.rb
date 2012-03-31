class Admin::DictonaryController < ApplicationController
  before_filter :check_of_existence_administrator
  before_filter :check_for_administrating
  def index
  end
end
