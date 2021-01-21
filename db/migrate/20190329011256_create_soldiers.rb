class CreateSoldiers < ActiveRecord::Migration[6.0]
  def change
    create_table :soldiers do |t|
      t.string :name
      t.integer :social_security
      t.integer :confirmed_kills
      t.string :resume
      t.integer :combat_experience
      t.integer :user_id

      t.timestamps
    end
  end
end
