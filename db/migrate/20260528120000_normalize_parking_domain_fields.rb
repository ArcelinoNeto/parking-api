class NormalizeParkingDomainFields < ActiveRecord::Migration[6.1]
  def up
    change_column :reservations, :entry, :datetime, using: "entry::timestamp"
    change_column :reservations, :exit, :datetime, using: "exit::timestamp"
    change_column :payments, :value, :decimal, precision: 10, scale: 2, using: "value::numeric"
  end

  def down
    change_column :payments, :value, :string
    change_column :reservations, :exit, :string
    change_column :reservations, :entry, :string
  end
end
