class PostsController < ApplicationController

  def index
    if tag_filter_params[:tag_filter]
      @posts = Post.with_tag(tag_filter_params[:tag_filter])
    else
      @posts = Post.order(:created_at => :desc)
    end
  end

  def show
    # build in the stub functionality
    @post = Post.find_by_id(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      @post.replace_or_build_tags(tag_params[:tags])
      flash[:success] = "Your post has saved successfully"
      redirect_to @post
    else
      flash.now[:error] = "There was a problem creating your post, error messages: #{ @post.errors.full_messages }!"
      render :new
    end
  end

  def edit
    @post = Post.find_by_id(params[:id])
    @tags = @post.tag_list
  end

  def update
    post = Post.find_by_id(params[:id])
    if post
      if post.update_attributes(post_params)
        post.replace_or_build_tags(tag_params[:tags])
        flash[:succes] = "Your post has been updated"
        redirect_to post
      else
        flash.now[:error] = "There was a propblem updating your post, error messages: #{ post.errors.full_messages }!"
        render :edit
      end
    else
      flash.now[:error] = "Your post could not be updated because it couldn't be found!"
      render :edit
    end
  end

  def destroy
    @post = Post.find_by_id(params[:id])
    if @post
      if @post.delete
        flash[:success] = "Your @post has been deleted"
        redirect_to posts_path
      else
        flash[:error] = "Your @post could not be deleted, errors are #{ error_messages_for @post}"
        render :edit
      end
    end
  end


  private

    def post_params
      params.require(:post).permit(:body,:title)
    end

    def tag_params
      params.permit(:tags)
    end

    def tag_filter_params
      params.permit(:tag_filter)
    end

end
