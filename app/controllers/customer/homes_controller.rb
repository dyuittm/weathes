class Customer::HomesController < ApplicationController

  def top
    @posts = Post.all
  end
end
