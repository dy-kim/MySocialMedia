# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create!(comment_params)

    respond_to do |format|
      format.html { redirect_to article_path(@article) }
      format.js { flash[:notice] = '댓글이 작성되었습니다.' }
    end
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to article_path(@article) }
      format.js { flash[:notice] = '댓글이 삭제되었습니다.' }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end
end
