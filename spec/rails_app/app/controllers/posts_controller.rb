class PostsController < ApplicationController
  include FaceB::Rails::Controller
  
  def index
    render 'index'
  end
end