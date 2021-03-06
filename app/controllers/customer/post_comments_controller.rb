class Customer::PostCommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    comment = current_customer.post_comments.new(post_comment_params)
    comment.post_id = @post.id
    comment.save
    render :post_comments
  end

  def destroy
    PostComment.find(params[:id]).destroy
    @post = Post.find(params[:post_id])
    render :post_comments
  end

  private
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end

