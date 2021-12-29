class NftsController < ApplicationController
  def index
    @nfts = policy_scope(Nft)
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
end
