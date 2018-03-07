class UsersController < ApplicationController
  def new
  end

  def create
  	User.create(name: params[:name],email: params[:email],password: params[:password])
    redirect_to '/'
  end
end
