class NftsController < ApplicationController
  def index
    if params[:sort].present?
      @nfts = policy_scope(Nft).order(params[:sort] + " " + params[:order]) # sorting
    elsif params[:query].present?
      @nfts = policy_scope(Nft).find_by_name(params[:query]) # Search
    else
      @nfts = policy_scope(Nft)
    end

    # the `geocoded` scope filters only flats with coordinates (latitude & longitude)
    @markers = @nfts.geocoded.map do |nft|
      {
        lat: nft.latitude,
        lng: nft.longitude
      }
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

  def search_by_nft_name(name)
    return this.find{|nft| nft.name.include?(params[:query])}
  end
end
