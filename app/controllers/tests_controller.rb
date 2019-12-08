require 'pry'
class TestsController < ApplicationController
  def index
    @tests = Test.all
    binding.pry
  end
end
