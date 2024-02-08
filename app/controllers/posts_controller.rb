# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create update destroy]

  def show
    @post = Post.find(params[:id])
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

    not_found unless @post

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
      redirect_to root_path, notice: t('.failure'), status: :unprocessable_entity
    end
  end

  def post_params
    params.require(:post).permit(:title, :body, :category_id)
  end
end
