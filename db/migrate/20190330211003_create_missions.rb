class CreateMissions < ActiveRecord::Migration[6.0]
  def change
    create_table :missions do |t|
      t.integer :user_id
      t.integer :soldier_id
      t.integer :importances
      t.text :objectives

      t.timestamps
    end
  end
end
