class CategoriesController < ApplicationController
  def show
    @posts = Category.find_by(name: params[:name]).posts.order(created_at: :desc)
  end
end
