class NftsController < ApplicationController
  before_action :get_nft, only: [:show, :edit, :update, :destroy]
  has_scope :by_price, type: :hash, using: [:min, :max], as: :price

  def index
    @nfts = apply_scopes(policy_scope(Nft))
    @nfts = @nfts.order(params[:sort] + " " + params[:order]) if params[:sort].present? # sorting
    @nfts = @nfts.search_by_nft_name(params[:search]) if params[:search].present? # Search

    @markers = set_geo_marker(@nfts) # the `geocoded` scope filters only flats with coordinates (latitude & longitude)
  end

  def show
    @reservation = Reservation.new
    authorize(@nft)
  end

  def new
    @nft = Nft.new
    authorize(@nft)
  end

  def create
    @nft = Nft.new(nft_params)
    @nft.user = current_user
    authorize(@nft)

    if @nft.save
      redirect_to nft_path(@nft)
    else
      render 'new'
    end
  end

  def edit
    authorize(@nft)
  end

  def update
    authorize(@nft)

    if @nft.update(nft_params)
      redirect_to nft_path(@nft)
    else
      render :edit
    end
  end

  def destroy
    @nft.destroy
    authorize(@nft)

    redirect_to params[:redirect_to] || nfts_path
  end

  private

  def nft_params
    params.require(:nft).permit(:name, :price, :address, :description, :image)
  end

  def get_nft
    @nft = Nft.find(params[:id])
  end

  def set_geo_marker(nfts)
    if @nfts.present?
      @markers = nfts.geocoded.map do |nft|
        {
          lat: nft.latitude,
          lng: nft.longitude
        }
      end
    end
  end
end
