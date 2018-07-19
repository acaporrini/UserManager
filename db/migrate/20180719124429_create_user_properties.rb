class CreateUserProperties < ActiveRecord::Migration[5.2]
  def change
    create_table :user_properties do |t|
      t.string :name
      t.string :value
      t.references :user, foreign_key: true
    end

    add_index :user_properties, [:user_id, :name]
  end
end
