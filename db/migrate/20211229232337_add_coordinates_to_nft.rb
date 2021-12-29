class AddCoordinatesToNft < ActiveRecord::Migration[6.1]
  def change
    add_column :nfts, :latitude, :float
    add_column :nfts, :longitude, :float
  end
end
