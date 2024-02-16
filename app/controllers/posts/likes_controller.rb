# frozen_string_literal: true

class Posts::LikesController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]

  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.find_or_initialize_by(user: current_user)

    respond_to do |format|
      if @like.new_record? && @like.save
        format.turbo_stream { render turbo_stream: turbo_stream.replace("like_button_post_id#{@post.id}", partial: 'posts/likes', locals: { post: @post, user_like: @like }) }
      else
        format.html { redirect_to @post, alert: t('.failure') }
      end
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @like = @post.likes.find_by(user: current_user)

    respond_to do |format|
      if @like&.destroy
        format.turbo_stream { render turbo_stream: turbo_stream.replace("like_button_post_id#{@post.id}", partial: 'posts/likes', locals: { post: @post, user_like: nil }) }
      else
        format.html { redirect_to @post, alert: t('.failure') }
      end
    end
  end
end
