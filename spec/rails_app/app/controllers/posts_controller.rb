class PostsController < ApplicationController
  include Facebook::Rails::Controller
  
  def index
    render 'index'
  end
end