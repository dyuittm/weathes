class Admin::PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]

  def index
    @posts = Post.all
  end

  def show
    @customer = @post.customer
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:notice] = 'You have updated post successfully.'
      redirect_to admin_post_path(@post)
    else
      flash[:alert] = 'Posting updated failed!!'
      render :edit
    end

    if params[:post][:image_ids]
      params[:post][:image_ids].each do |image_id|
        image = @post.post_images.find(image_id)
        image.purge
      end
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :body, post_images: [])
  end

  def set_post
    @post = Post.find(params[:id])
  end

end
