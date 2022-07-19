class SearchesController < ApplicationController

  def search
	@model = params[:model]
	@content = params[:content]
	if @model == 'customer'
	  @records = Customer.search_for(@content)
	elsif @model == 'post'
	  @records = Post.search_for(@content)
	elsif @model == 'prefecture'
	  if Prefecture.exists?(name: @content)
	    @prefecture = Prefecture.find_by(name: @content)
	    @records = @prefecture.customers
	  else
	    @records = Customer.all
	  end
	end
  end

end