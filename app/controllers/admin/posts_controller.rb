class Admin::PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.page(params[:page]).order(created_at: :desc)
  end

  def show
    @customer = @post.customer
  end

  def edit
  end

  def update
    if params[:post][:image_ids]
      params[:post][:image_ids].each do |image_id|
        image = @post.post_images.find(image_id)
        image.purge
      end
    end

    if @post.update(post_params)
      flash[:notice] = '投稿を更新しました'
      redirect_to admin_post_path(@post)
    else
      flash[:alert] = '更新できませんでした'
      @posts = Post.page(params[:page]).order(created_at: :desc)
      render :index
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = '投稿を削除しました'
    redirect_to admin_posts_path
  end


  private
  def post_params
    params.require(:post).permit(:title, :body, post_images: [])
  end

  def set_post
    @post = Post.find(params[:id])
  end

end
