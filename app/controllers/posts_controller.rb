class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def show
    # build in the stub functionality
    @post = Post.find_by_id(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    if post.save
      flash[:success] = "Your post has saved successfully"
      redirect_to post
    else
      flash.now[:error] = "There was a problem creating your post, error messages: #{ error_messages_for post }!"
      render :new
    end
  end

  def edit
    @post = Post.find_by_id(params[:id])
  end

  def update
    post = Post.find_by_id(params[:id])
    if post
      if post.update_attributes(post_params)
        flash[:succes] = "Your post has been updated"
        redirect_to post
      else
        flash.now[:error] = "There was a propblem updating your post, error messages: #{ error_messages_for post }!"
        render :edit
      end
    else
      flash.now[:error] = "Your post could not be updated because it couldn't be found!"
      render :edit
    end
  end


  private

    def post_params
      params.require(:post).permit(:body,:title)
    end

end
