class NftsController < ApplicationController
  def index
    @Nfts = policy_scope(Nft)
  end

  def new
    @nft = Nft.new
    authorize(@nft)
  end
end
