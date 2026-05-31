class CommentsController < ApplicationController
  def create
    @comment = Comment.new
    @comment["body"] = params["body"]
    @comment["post_id"] = params["post_id"]
    @comment["user_id"] = session["user_id"]
    @comment.save
    redirect_to "/posts"
  end

  def destroy
  @comment = Comment.find_by({ "id" => params["id"] })
  if @comment["user_id"] == session["user_id"]
    @comment.destroy
  end
  redirect_to "/posts"
  end
  
end