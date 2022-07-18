class Customer::PostsController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_customer, only: [:edit, :update, :destroy]

  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
    if @post.save
      flash[:notice] = 'You have created post successfully.'
      redirect_to post_path(@post)
    else
      flash[:alert] = 'Posting failed!!'
      @posts = Post.all
      render :index
    end
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @customer = @post.customer
    @post_new = Post.new
    @post_comment = PostComment.new
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:notice] = 'You have updated post successfully.'
      redirect_to post_path(@post)
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

  def destroy
    @post.destroy
    redirect_to customer_path(current_customer)
  end

  private
  def post_params
    params.require(:post).permit(:title, :body, post_images: [])
  end
  #only login_user
  def ensure_correct_customer
    @post = Post.find(params[:id])
    unless @post.customer == current_customer
      redirect_to posts_path
    end
  end

end
