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
    @posts = Post.page(params[:page]).order(created_at: :desc)
    image_count = params[:post][:image_ids]&.count || 0
    if (@post.post_images.count == image_count && !params[:post][:post_images])
      flash[:alert] = '画像の登録がないため変更できませんでした'
      render :edit and return
    end
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
      #バリデーション/エラーメッセージ
      error_messages = @post.errors.messages
      #再度@postを取ることで余剰分の画像を非表示
      @post = Post.find(params[:id])
      #上記の＠postの取得でバリデーションが無効になるため、表示させるため取得
      #key => model values => modelに対してのいくつかのエラーメッセージ（エラーの種類が複数あるため複数形）
      #更にvalueで一つづつ表示させる
      error_messages.each{|key, values|
        values.each do |value|
          @post.errors.add(key, value)
        end
      }
      flash[:alert] = '更新できませんでした'
      render :edit
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
