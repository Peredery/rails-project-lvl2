class Posts::LikesController < ApplicationController
  before_action :authenticate_user!,  only: [ :create, :destroy ]

  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.build(user: current_user)

    respond_to do |format|
      if @like.save
        format.turbo_stream { render turbo_stream: turbo_stream.replace("like_button", partial: "posts/likes", locals: { post: @post }) }
        format.html { redirect_to @post, notice: "You liked this post." }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace("like_button", partial: "posts/likes", locals: { post: @post }) }
        format.html { redirect_to @post, alert: "You already liked this post." }
      end
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @like = @post.likes.find_by(user: current_user)

    respond_to do |format|
      if @like&.destroy
        format.turbo_stream { render turbo_stream: turbo_stream.replace("like_button", partial: "posts/likes", locals: { post: @post }) }
        format.html { redirect_to @post, notice: "You unliked this post." }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace("like_button", partial: "posts/likes", locals: { post: @post }) }
        format.html { redirect_to @post, alert: "You already unliked this post." }
      end
    end
  end
end
