# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :find_article

  def create
    @likes = @article.likes
    @like = @likes.create(user_id: current_user.id) if user_signed_in?

    respond_to do |format|
      format.html { redirect_to article_path(@article) }
      format.js
    end
  end

  def destroy
    like_to_destroy = @article.likes.find_by(user_id: current_user.id)

    if like_to_destroy.nil?
      flash[:notice] = "Cannot unlike"
    else
      like_to_destroy.destroy
    end

    redirect_to article_path(@article)
  end

  private

  def find_article
    @article = Article.find(params[:article_id])
  end
end
