class Api::V1::StoresController < Api::V1::ApiController
  before_action :set_store, only: [:show]

  def index
    @stores = Store.within(params[:longitude].to_f, params[:latitude].to_f)
                   .sort_by(&:ratings_average).reverse
  end

  def show; end

  private

  def set_store
    @store = Store.find_by!(google_place_id: params[:id])
  end
end
