class PostsController < ApplicationController
  before_filter :authenticate_admin!, :except => [:index, :show, :archives]
  before_filter :set_blog_flag

  def index
    if tag_filter_params[:tag_filter]
      posts = Post.with_tag(tag_filter_params[:tag_filter])
      # puts "\n\n\n POSTS IS: #{posts.inspect}!!!"
    elsif date_filter_params[:filter_month] && date_filter_params[:filter_year]
      posts = Post.by_archive_date(date_filter_params[:filter_month],date_filter_params[:filter_year])
      # puts "\n\n\n\n\n\n\n\n DATE FILTER POSTS IS: #{posts.inspect}!!!\n\n\n\n\n"
    else
      posts = Post.order(:created_at => :desc)
      # puts "\n\n\n\n\n\n\n\n REGULAR POSTS IS: #{posts.inspect}!!!\n\n\n\n\n"
    end
    if params[:order] == "rev_chron"
      posts = posts.order_rev_chron
    elsif params[:order] == "chron"
      posts = posts.order_chron
    end
    @posts = posts.paginate(:page => params[:page], :per_page => 5)
    # puts "\n\n\n NOW @POSTS IS #{@posts.inspect}!! \n\n\n"
  end

  def archives
    @tags = Tag.by_posts
    @archives = Post.archives
  end

  def show
    # build in the stub functionality
    @post = Post.friendly.find(params[:id])
    @next = @post.next
    @prev = @post.prev
    if request.path != post_path(@post)
      redirect_to @post, :status => :moved_permanently
    end
  end

  def new
    @post = Post.new
  end

  # for refactoring: friendly find throws an exception, not T/F
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
    @post = Post.friendly.find(params[:id])
    @tags = @post.tag_list
  end

  # for refactoring: friendly find throws an exception, not T/F
  def update
    post = Post.friendly.find(params[:id])
    if post
      if post.update_attributes(post_params)
        post.replace_or_build_tags(tag_params[:tags])
        post.slug = nil # because slugs only regenerate if nil
        post.save!
        flash[:succes] = "Your post has been updated"
        redirect_to post
      else
        flash.now[:error] = "There was a problem updating your post, error messages: #{ post.errors.full_messages }!"
        render :edit
      end
    else
      flash.now[:error] = "Your post could not be updated because it couldn't be found!"
      render :edit
    end
  end

  # for refactoring: friendly find throws an exception, not T/F
  def destroy
    @post = Post.friendly.find(params[:id])
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
      params.require(:post).permit(:body,:title,:created_at)
    end

    def tag_params
      params.permit(:tags)
    end

    def tag_filter_params
      params.permit(:tag_filter)
    end

    def date_filter_params
      puts "\n\n\n params is: #{params.inspect}!"
      newparams = params.permit(:filter_month, :filter_year)
      puts "\n\n\n newparams is: #{newparams.inspect}!"
      newparams
    end

    def set_blog_flag
      @blog = true
    end

end
