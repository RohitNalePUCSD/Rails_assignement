class PostsController < ApplicationController
    protect_from_forgery with: :null_session

    def index
        @posts = Post.all
        render(json: @posts)
    end

    def show
        @post = Post.find(params[:id])
        render(json: @post)
        rescue ActiveRecord::RecordNotFound => e
        render json: {
          error: e.to_s
        }, status: :not_found
    end

    def create
        @post = Post.new(params.permit(:title, :content))
        @post.save
        render(json: @post)
        rescue ActiveRecord::RecordNotFound => e
        render json: {
          error: e.to_s
        }, status: :not_found
    
    end

    def update
        @post = Post.find(params[:id])
        @post.update(post_params)
        render(json: {message: "Update Sucessfully!!!!"})
        rescue ActiveRecord::RecordNotFound => e
        render json: {
          error: e.to_s
        }, status: :not_found
    
    end

    def destroy
        @post = Post.find(params[:id])
        @post.destroy
        render json: {message: "Delete successfully!!!"}
        rescue ActiveRecord::RecordNotFound => e
        render json: {
          error: e.to_s
        }, status: :not_found
    end

    private
    def post_params
        params.require(:post).permit(:title, :content)
    end
end
