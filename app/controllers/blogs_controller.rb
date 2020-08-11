class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :set_current_user

  include SessionsHelper

  def set_current_user
    #session[:user_id]に格納されているIDを元にユーザデータを格納
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def authenticate_user
    if @current_user == nil
      flash[:notice] = "ログインが必要です。"
      redirect_to new_session_path
    else
      redirect_to blogs_path
    end
  end

  # GET /blogs
  # GET /blogs.json
  def index
    @blogs = Blog.all.order(created_at: :desc)
    @current_user ||= Blog.find_by(id: session[:user_id])
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
  end

  # GET /blogs/new
  def new
    # @blog.user_id = current_user.id
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

  def correct_user
     note = Blog.find(params[:id])
     if current_user.id = blog.user_id
       redirect_to new_session_path
     end
  end
end
