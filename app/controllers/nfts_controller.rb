class NftsController < ApplicationController
  def index
    @Nfts = policy_scope(Nft)
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

  private

  def nft_params
    params.require(:nft).permit(:name, :price, :address, :description, :image)
  end
end
