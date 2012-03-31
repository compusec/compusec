class Admin::Dictonary::ScientificRankController < Admin::DictonaryController
  def index
    @scientific_ranks = ScientificRank.all
  end

  def new
    if request.post?
      scientific_rank = ScientificRank.new(:name => params[:name])
      if scientific_rank.save
        redirect_to :controller => 'admin/dictonary/scientific_rank', :action => 'index'
      else
        #проверка формы
      end
    end
  end

  def show
  end

  def destroy
    scientific_rank = ScientificRank.find(params[:id])
    scientific_rank.destroy
    redirect_to :controller => 'admin/dictonary/post', :action => 'index'
  end

  def edit
    @scientific_rank = ScientificRank.find(params[:id])
    if request.post?
      if @scientific_rank.update_attributes(:name => params[:name])
        redirect_to :controller => 'admin/dictonary/scientific_rank', :action => 'index'
      else
        #проверка формы
      end
    end
  end
end
