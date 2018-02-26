class HomeController < ApplicationController
  def index
  	@posts = Post.all # 모델안에 있는 모든 정보저장
  end

  def new
  end

  def create
  	@post = Post.new #테이블의 한 행을 추가
  	@post.title = params[:post_title] 
  	@post.content = params[:post_content]
  	@post.save #테이블에 써준 내용 모두 저장

  	redirect_to '/'
  end

  def edit
    @post = Post.find(params[:post_id])
  end

  def update
    post = Post.find(params[:post_id])
    post.title = params[:post_title] 
    post.content = params[:post_content]
    post.save #테이블에 써준 내용 모두 저장
    redirect_to '/'
  end

  def destroy
    post = Post.find(params[:post_id])
    post.destroy
    redirect_to '/'
  end
end
