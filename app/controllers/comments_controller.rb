class CommentsController < ApplicationController
  def create
    if user_signed_in?
      @comment = Comment.new
      @comment.post_id = params[:post_id]
      @comment.content = params[:comment]
      @comment.user_id = current_user.id
      @comment.save
      redirect_to "/"
    else
      redirect_to '/'
    end
  end
  
  def delete
    if user_signed_in?
      @comment = Comment.find(params[:comment_id])
      @comment.destroy
      redirect_to '/'
    else
      redirect_to '/'
    end
  end
end
