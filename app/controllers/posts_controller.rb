# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy]

  def index
    @posts = Post.includes(:creator).order(created_at: :desc)
    @user_likes = current_user ? current_user.likes.pluck(:post_id) : []
  end

  def show
    @post = Post.includes(:comments, :creator).find(params[:id])
    @empty_comment = @post.comments.build
    @comments = @post.comments.includes(:user).arrange(order: :created_at)
    @user_like = current_user.likes.find_by(post: @post) if current_user
  end

  def new
    @post = Post.new
  end

  def edit
    @post = set_post
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
    @post = set_post

    if @post.update(post_params)
      redirect_to @post, notice: t('.success')
    else
      render :edit, notice: t('.failure'), status: :unprocessable_entity
    end
  end

  def destroy
    @post = set_post

    if @post.destroy
      redirect_to root_path, notice: t('.success')
    else
      redirect_to root_path, notice: t('.failure'), status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :category_id)
  end

  def set_post
    @set_post ||= current_user.posts.find(params[:id])
  end
end
