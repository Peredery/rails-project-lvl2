class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create update destroy]

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])

    not_found unless @post

    if @post.update(post_params)
      redirect_to @post, notice: "Post updated successfully"
    else
      render :edit, notice: "Post could not be updated", status: :unprocessable_entity
    end
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post, notice: "Post created successfully"
    else
      render :new, notice: "Post could not be created", status: :unprocessable_entity
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    if @post.destroy
      redirect_to root_path, notice: "Post deleted successfully"
    else
      redirect_to root_path, notice: "Post could not be deleted", status: :unprocessable_entity
    end
  end

  def post_params
    params.require(:post).permit(:title, :body, :category_id)
  end
end
