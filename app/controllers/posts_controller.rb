# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy]

  def index
    @category = Category.find_by(name: params[:category_name])
    @posts = @category ? Post.includes(:creator).order(created_at: :desc).where(category: @category.presence) : Post.includes(:creator).order(created_at: :desc)
    @user_likes = @user_likes = current_user ? current_user.likes.index_by(&:post_id) : {}
  end

  def show
    @post = Post.includes(comments: :user).find(params[:id])
    @empty_comment = @post.comments.build
    @comments = @post.comments.arrange(order: :created_at)
    @user_like = current_user.likes.find_by(post: @post) if current_user
  end

  def new
    @post = Post.new
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post, notice: t('.success')
    else
      render :new, notice: t('.failure'), status: :unprocessable_entity
    end
  end

  def update
    @post = current_user.posts.find(params[:id])

    if @post.update(post_params)
      redirect_to @post, notice: t('.success')
    else
      render :edit, notice: t('.failure'), status: :unprocessable_entity
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])

    if @post.destroy
      redirect_to root_path, notice: t('.success')
    else
      redirect_to root_path, notice: t('.failure')
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :category_id)
  end
end
