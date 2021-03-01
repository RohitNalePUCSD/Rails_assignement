class CommentsController < ApplicationController
    protect_from_forgery with: :null_session
    before_action :get_post
    before_action :get_comment, only: [:show, :update, :destroy]

    def index
      @comments = @post.comments
      render(json: @comments)
    end

    def show
      render(json: @comment)
    end

    def create
      @post.comments.create(comment_params)
      render(json: @comment)
    end

    def update
        @comment.update(comment_params)
        render(json: @comment)
    end

    def destroy
        @comment.destroy
        render(json: {message: "Delete sucessfully!!!!"})
    end

    private 
    def get_post
        @post = Post.find(params[:post_id])
    end

    def comment_params
        params.require(:comment).permit(:name, :message)
    end

    def get_comment
        @comment = @post.comments.find(params[:id]) if @post
    end
end
