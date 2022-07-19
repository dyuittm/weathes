class SearchesController < ApplicationController

  def search
		@model = params[:model]
		@content = params[:content]
		if @model == 'customer'
			@records = Customer.search_for(@content)
		elsif @model == 'Post'
			@records = Post.search_for(@content)
		else
			@records = Prefecture.search_for(@content)
		end
	end

end