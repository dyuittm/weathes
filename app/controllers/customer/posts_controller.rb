class Customer::PostsController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_customer, only: [:edit, :update, :destroy]

  def create
    @post_new = Post.new(post_params)
    @post_new.customer_id = current_customer.id
    if @post_new.save
      flash[:notice] = '投稿しました'
      redirect_to post_path(@post_new)
    else
      flash[:alert] = '投稿できませんでした'
      @customer = current_customer
      @posts = @customer.posts.page(params[:page]).order(created_at: :desc)
      render "customer/customers/show"
    end
  end

  def index
    @posts = Post.page(params[:page]).order(created_at: :desc)
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
    if params[:post][:image_ids]
      params[:post][:image_ids].each do |image_id|
        image = @post.post_images.find(image_id)
        image.purge
      end
    end

    if @post.update(post_params)
      flash[:notice] = '投稿を変更しました'
      redirect_to post_path(@post)
    else
      flash[:alert] = '変更できませんでした'
      @posts = Post.page(params[:page]).order(created_at: :desc)
      render :index
    end

  end

  def destroy
    @post.destroy
    flash[:notice] = '投稿を削除しました'
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
