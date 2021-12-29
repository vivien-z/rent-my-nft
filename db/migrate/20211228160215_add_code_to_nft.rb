class AddCodeToNft < ActiveRecord::Migration[6.1]
  def change
    add_column :nfts, :code, :string
  end
end
