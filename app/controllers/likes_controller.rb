# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :find_article, :find_like, :authenticate_user!

  def create
    if @like.nil?
      @like = @article.likes.create(user_id: current_user.id)
    end

    respond_to do |format|
      format.html { redirect_to article_path(@article) }
      format.js
    end
  end

  def destroy
    if @like.nil?
      flash[:notice] = 'Cannot unlike!'
    else
      @like.destroy
    end

    respond_to do |format|
      format.html { redirect_to article_path(@article) }
      format.js
    end
  end

  private

  def find_article
    @article = Article.find(params[:article_id])
  end

  def find_like
    @like = @article.likes.find_by(user_id: current_user.id)
  end
end
