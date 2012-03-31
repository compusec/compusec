class Admin::Dictonary::PostController < Admin::DictonaryController
  def index
    @posts = Post.all
  end

  def new
    if request.post?
      post = Post.new(:name => params[:name])
      if post.save
        redirect_to :controller => 'admin/dictonary/post', :action => 'index'
      else
        #проверка формы
      end
    end
  end

  def show
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to :controller => 'admin/dictonary/post', :action => 'index'
  end

  def edit
    @post = Post.find(params[:id])
    if request.post?
      if @post.update_attributes(:name => params[:name])
        redirect_to :controller => 'admin/dictonary/post', :action => 'index'
      else
        #проверка формы
      end
    end
  end
end
