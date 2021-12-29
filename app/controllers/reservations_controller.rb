class ReservationsController < ApplicationController
  def create
    @reservation = Reservation.new(reservation_params)
    @nft = Nft.find(params[:nft_id])
    @reservation.nft = @nft
    @reservation.user = current_user

    authorize(@reservation)

    if @reservation.save
      redirect_to reservation_path(@reservation), notice: "NFT successfully reserved."
    else
      render 'nfts/show'
    end
  end

  def edit
    @reservation = Reservation.find(params[:id])
    authorize(@reservation)
  end

  def update
    @reservation = Reservation.find(params[:id])
    authorize(@reservation)

    if @reservation.update(reservation_params)
      redirect_to nft_path(@reservation.nft.id), notice: "NFT reservation is successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy

    authorize(@reservation)

    redirect_to user_path(current_user)
  end

  private 

  def reservation_params
    params.require(:reservation).permit(:starting_date, :ending_date, :address)
  end
end
