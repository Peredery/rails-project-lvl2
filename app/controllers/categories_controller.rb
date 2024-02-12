# frozen_string_literal: true

class CategoriesController < ApplicationController
  def show
    @posts = Category.find_by(name: params[:name]).posts.order(created_at: :desc)
    @user_likes = current_user ? current_user.likes.pluck(:post_id) : []
  end
end
