class NftsController < ApplicationController
  has_scope :by_price, :using => [:price_min, :price_max]

  def index
    @nfts = apply_scopes(policy_scope(Nft)).all
    @nfts = @nfts.order(params[:sort] + " " + params[:order]) if params[:sort].present? # sorting
    @nfts = @nfts.search_by_nft_name(params[:search]) if params[:search].present? # Search

    # the `geocoded` scope filters only flats with coordinates (latitude & longitude)
    if @nfts.present?
      @markers = @nfts.geocoded.map do |nft|
        {
          lat: nft.latitude,
          lng: nft.longitude
        }
      end
    end
  end

  def show
    @nft = Nft.find(params[:id])
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
    @nft = Nft.find(params[:id])
    authorize(@nft)
  end

  def update
    @nft = Nft.find(params[:id])
    authorize(@nft)

    if @nft.update(nft_params)
      redirect_to nft_path(@nft)
    else
      render :edit
    end
  end

  def destroy
    @nft = Nft.find(params[:id])
    @nft.destroy
    authorize(@nft)
    # redirect to the url provided in the query string (after || save from code break situation)
    redirect_to params[:redirect_to] || nfts_path
  end

  private

  def nft_params
    params.require(:nft).permit(:name, :price, :address, :description, :image)
  end

  # def search_by_nft_name(name)
  #   return this.find{|nft| nft.name.include?(params[:search])}
  # end
end
