class CreatePlayers < ActiveRecord::Migration[6.1]
  def change
    create_table :players do |t|
      t.string :first_name
      t.string :last_name
      t.date :date_of_birth
      t.integer :playing_position
      t.string :country

      t.timestamps
    end
  end
end
