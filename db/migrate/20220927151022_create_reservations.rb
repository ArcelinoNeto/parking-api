class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.string :plate
      t.string :entry
      t.string :exit
      t.integer :status

      t.timestamps
    end
  end
end
