class CreateBadges < ActiveRecord::Migration[6.1]
  def change
    create_table :badges do |t|
      t.string :name, null: false
      t.references :question, null: false, foreign_key: true
      t.references :winner, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
