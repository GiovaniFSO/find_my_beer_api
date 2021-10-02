class Api::V1::GoogleStoresController < Api::V1::ApiController
  def index
    render json: GoogleStore.all(latitude: params[:latitude].to_f, longitude: params[:longitude].to_f)
  end

  def show
    render json: GoogleStore.find(params[:id])
  end
end
