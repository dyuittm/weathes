class Customer::CustomersController < ApplicationController
  before_action :ensure_correct_customer, only: [:edit, :update, :withdraw]
   before_action :ensure_guest_user, only: [:edit]

  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
    @post_new = Post.new
    @posts = @customer.posts
  end

  def favorites
    @customer = Customer.find(params[:id])
    favorites= Favorite.where(customer_id: @customer.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
  end

  def edit
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to customer_path(@customer), notice: "更新しました"
    else
      render :edit
    end
  end

  def unsubscribe
    @customer = Customer.find(params[:id])
  end

  def withdraw
    @customer = Customer.find(params[:id])
    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path, notice: "退会処理を実行いたしました"
  end

  private
  def customer_params
    params.require(:customer).permit(:prefecture_id ,:last_name, :first_name, :last_name_kana, :first_name_kana, :user_name, :introduction, :email, :is_deleted, :profile_image)
  end
  #only login_user
  def ensure_correct_customer
    @customer = Customer.find(params[:id])
    unless @customer == current_customer
      redirect_to root_path
    end
  end

  #guestuser cannot be edited
  def ensure_guest_user
    @customer = Customer.find(params[:id])
    if @customer.user_name == "guestuser"
      redirect_to customer_path(current_customer) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end

end
