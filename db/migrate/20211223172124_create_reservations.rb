class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :nft, null: false, foreign_key: true
      t.date :starting_date
      t.date :ending_date
      t.text :address

      t.timestamps
    end
  end
end
