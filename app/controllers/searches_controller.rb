class SearchesController < ApplicationController

  def search
		@model = params[:model]
		@content = params[:content]
		if @model == 'customer'
			@records = Customer.search_for(@content)
		else
			@records = Post.search_for(@content)
		end
	end

end