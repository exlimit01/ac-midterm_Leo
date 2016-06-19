class PostsController < ApplicationController

  before_action :set_post, :only => [ :show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :check_user, :only => [:edit, :update, :destroy]

  def index
    @posts = Post.page(params[:page]).per(5)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      flash[:notice] = "新增資訊成功"
      redirect_to posts_path
    else
      render :new
    end

  end

  def show
    @page_tittle = @post.name
    @comment = Comment.new
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "更新資訊成功"
      redirect_to posts_path
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:alert] = "刪除資訊成功"
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:name, :content, :category_id)
  end

  def set_post
    @post = Post.find(params[:id])
  end

    def check_user
    if @post.user != current_user
      flash[:alert] = '你不是作者,沒有此權限'
      redirect_to posts_path
      return
    end
  end

end
