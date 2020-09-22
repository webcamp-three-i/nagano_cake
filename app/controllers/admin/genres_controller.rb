class Admin::GenresController < ApplicationController

	def index
		@genre = Genre.new
		#page(params[:page]).per(10)はkaminariのメソッドです。
		@genres = Genre.all.page(params[:page]).per(10)
	end

	def create
		@genre = Genre.new(genre_params)
		if @genre.save
			#保存成功でindexに行くようにしています。
			redirect_to admin_genres_path
		else
			@genres = Genre.all.page(params[:page]).per(10)
      		render :index
      	end
	end

	def edit
		@genre = Genre.find(params[:id])
	end

	def update
		@genre = Genre.find(params[:id])
		if @genre.update(genre_params)
			redirect_to admin_genres_path
		else
			render :edit
		end
	end

	private
	def genre_params
		params.require(:genre).permit(:name, :valid_flag)
	end
end
