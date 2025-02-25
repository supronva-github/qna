class CreateVotes < ActiveRecord::Migration[6.1]
  def change
    create_table :votes do |t|
      t.references :user, foreign_key: { on_delete: :nullify }
      t.references :votable, polymorphic: true, null: false
      t.integer :value, null: false, default: 0

      t.timestamps
    end

    add_index :votes, %i[user_id votable_type votable_id], unique: true

    execute <<-SQL
      ALTER TABLE votes ADD CONSTRAINT check_vote_value CHECK (value IN (-1, 0, 1));
    SQL
  end
end
