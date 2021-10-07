class UsersController < ApplicationController
  def index
    @users = User.all
  end
  def show
    @user = User.find([:id])
  end

  def update
    binding.irb  
  end
  
  private
  def set_user
    @user = User.find([:id])
  end
end
