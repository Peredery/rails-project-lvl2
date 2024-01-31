class Posts::CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(user_id: current_user.id, **comment_params)

    if @comment.save
      redirect_to @post, notice: "Comment created successfully"
    else
      redirect_to @post, notice: "Comment could not be created", status: :unprocessable_entity
    end
  end

  def edit
    @comment = current_user.comments.find(params[:id])
    @post = Post.find_by_id(id: params[:post_id])
  end

  def update
    @comment = current_user.comments.find(params[:id])

    if @comment.update(comment_params)
      redirect_to @comment.post, notice: "Comment updated successfully"
    else
      render :edit, notice: "Comment could not be updated", status: :unprocessable_entity
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])

    if @comment.update(content: "comment deleted")
      redirect_to @comment.post, notice: "Comment deleted successfully"
    else
      redirect_to @comment.post, notice: "Comment could not be deleted", status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:post_comment).permit(:content, :parent_id)
  end
end
