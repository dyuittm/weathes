class SearchesController < ApplicationController

  def search
		@model = params[:model]
		@content = params[:content]
		if @model == 'customer'
		  @records = Customer.search_for(@content).page(params[:page])
		elsif @model == 'post'
		  @records = Post.search_for(@content).page(params[:page]).order(created_at: :desc)
		elsif @model == 'prefecture'
		  if Prefecture.exists?(name: @content)
		    @prefecture = Prefecture.find_by(name: @content)
		    @records = @prefecture.customers.page(params[:page])
		  else
		    @records = Customer.page(params[:page])
		  end
		end
  end

end