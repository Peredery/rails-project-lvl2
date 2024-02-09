# frozen_string_literal: true

class Posts::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :comment, only: %i[edit update destroy]

  def edit
    @post = Post.find_by_id(id: params[:post_id])
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(user_id: current_user.id, **comment_params)

    if @comment.save
      redirect_to @post, notice: t('.success')
    else
      redirect_to @post, notice: t('.failure'), status: :unprocessable_entity
    end
  end

  def update
    @comment = current_user.comments.find(params[:id])

    if @comment.update(comment_params)
      redirect_to @comment.post, notice: t('.success')
    else
      render :edit, notice: t('.failure'), status: :unprocessable_entity
    end
  end

  def destroy
    if @comment.soft_delete!(current_user.id)
      redirect_to @comment.post, notice: t('.success')
    else
      redirect_to @comment.post, notice: t('.failure'), status: :unprocessable_entity
    end
  end

  private

  def comment
    @comment = current_user.comments.find_by(params[:id], deleted: false)
  end

  def comment_params
    params.require(:post_comment).permit(:content, :parent_id)
  end
end
