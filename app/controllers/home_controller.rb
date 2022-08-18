class HomeController < ApplicationController
  before_action :set_name

  def index; end


  private

  def set_name
    @name = 'Israel'
  end
end