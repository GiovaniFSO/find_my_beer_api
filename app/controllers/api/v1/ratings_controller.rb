class Api::V1::RatingsController < Api::V1::ApiController
  def create
    ActiveRecord::Base.transaction do
      @store = Store.find_or_create_by!(store_params)
      @store.ratings.create!(rating_params)

      render json: @store.ratings.last
    end
  end

  private

  def store_params
    lonlat = "POINT (#{params[:store][:longitude].to_f} #{params[:store][:latitude].to_f})"
    params.require(:store).permit(:name, :address, :google_place_id).merge(lonlat: lonlat)
  end

  def rating_params
    params.require(:rating).permit(:value, :opinion, :user_name)
  end
end
