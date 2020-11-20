class FavoritesController < ApplicationController
  def create
    micropost = Micropost.find(params[:micropost_id])
    @favorite = current_user.favorite(micropost)
    if @favorite.save
      flash[:success] = 'お気に入りに追加しました。'
      redirect_back(fallback_location: root_path)
    else
      @microposts = current_user.microposts.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'お気に入りの追加に失敗しました。'
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    micropost = Micropost.find(params[:micropost_id])
    @favorite = current_user.unfavorite(micropost)
    flash[:success] = 'お気に入りを削除しました。'
    redirect_back(fallback_location: root_path)
  end
end
