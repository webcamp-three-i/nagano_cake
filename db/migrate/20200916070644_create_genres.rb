class CreateGenres < ActiveRecord::Migration[5.2]
  def change
    create_table :genres do |t|
      t.name :string
      t.boolean :valid_flag, default: true

      t.timestamps
    end
  end
end
