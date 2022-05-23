class CreateSeasons < ActiveRecord::Migration[6.1]
  def change
    create_table :seasons do |t|
      t.string :title
      t.integer :status

      t.timestamps
    end
  end
end
