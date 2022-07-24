class Customer::HomesController < ApplicationController

  def top
    @posts = Post.order('id DESC').limit(6)
  end
end
