class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :code_name
      t.boolean :general, default: false

      t.timestamps
    end
  end
end
