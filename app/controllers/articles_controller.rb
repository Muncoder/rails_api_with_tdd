class ArticlesController < ApplicationController

	def index
		articles = Article.recent
		render json: articles
	end

	def show
		render json: Article.find(params[:id])
	end

end
