class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email: params[:email])
  	if user && user.authenticate(params[:password])
  		session[:user_id] = user.id
  		redirect_to '/'
	else
	  	flash[:alert] = '로그인에 실패하셨습니다.'
	  	redirect_to new_session_path
	end
  end

  def destroy
  	session.delete(:user_id)

  	redirect_to '/'
  end
end
