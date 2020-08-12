class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user
  # include SessionsHelper

  def authenticate_user
    @current_user = User.find_by(id: session[:user_id])
    if @current_user.nil?
      flash[:notice] = "ログインが必要です。"
      redirect_to new_session_path
    end
  end

  # GET /blogs
  # GET /blogs.json
  def index
    @blogs = Blog.all.order(id: "DESC")
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
  end

  # GET /blogs/new
  def new
    if params[:back]
      @blog = Blog.new(blog_params)
    else
      @blog = Blog.new
    end
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs
  # POST /blogs.json
  def create
    current_user = User.find_by(id: session[:user_id])
    @blog = current_user.blogs.build(blog_params)

    if params[:back]
      render :new
    else
      if @blog.save
        redirect_to blogs_path, notice: "Blog was successfully created."
      else
        render :new
      end
    end
  end

  # PATCH/PUT /blogs/1
  # PATCH/PUT /blogs/1.json
  def update
    if @blog.update(blog_params)
      redirect_to blogs_path, notice: "'Blog was successfully updated.'"
    else
      render :edit
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url, notice: 'Blog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def confirm
    current_user = User.find_by(id: session[:user_id])
    @blog = current_user.blogs.build(blog_params)
    render :new if @blog.invalid?
  end

  private
  def set_blog
    @blog = Blog.find(params[:id])
  end

  def blog_params
    params.require(:blog).permit(:title, :content, :image, :image_cache, :user_id)
  end
end
