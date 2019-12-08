class TutorsController < ApplicationController
  def index
    @tests = Test.all
  end
end
