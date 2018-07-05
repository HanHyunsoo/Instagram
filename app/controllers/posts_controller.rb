class PostsController < ApplicationController
  def index
    # if user_signed_in?
    #   @posts = Post.all.reverse
    # else
    #   redirect_to '/users/sign_in'
    # end
      @posts = Post.all.reverse
  end

  def create
    if user_signed_in?
      temp_post = Post.new
      temp_post.title = params[:post_title]
      temp_post.content = params[:post_content]
      temp_post.user_id = current_user.id
      
      hashtags = params[:hashtags].split(',')
      hashtags.each do |tag|
        hashtag = Hashtag.find_or_create_by(name: tag.delete(''))
        hashtag.save
        temp_post.hashtags << hashtag
      end
      
      uploader = ImguploaderUploader.new
      uploader.store!(params[:img])
      temp_post.img_url = uploader.url
      
      temp_post.save
      redirect_to '/'
    else
      redirect_to '/'
    end
  end

  def delete
    if user_signed_in?
      temp_post = Post.find(params[:post_id])
      temp_post.destroy
          
      redirect_to '/'
    else
      redirect_to '/'
    end
  end
  
  def edit
    @post = Post.find(params[:post_id])
  end
  
  def update
    if user_signed_in?
      @post = Post.find(params[:post_id])
      @post.title = params[:post_title]
      @post.content = params[:post_content]
      @post.hashtags.clear
      hashtags = params[:hashtags].split(',')
      hashtags.each do |tag|
        hashtag = Hashtag.find_or_create_by(name: tag.delete(''))
        hashtag.save
        @post.hashtags << hashtag
      end
      
      @post.save
      
      redirect_to '/posts/index'
    else
      redirect_to '/'
    end
  end
end
