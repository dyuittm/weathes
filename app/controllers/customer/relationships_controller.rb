class Customer::RelationshipsController < ApplicationController

  def create
    current_customer.follow(params[:customer_id])
    redirect_to request.referer
  end

  def destroy
    current_customer.unfollow(params[:customer_id])
    redirect_to request.referer
  end

  def follow
    customer = Customer.find(params[:customer_id])
    @customers_followings = customer.followings
    @customers_followers = customer.followers
  end

end
