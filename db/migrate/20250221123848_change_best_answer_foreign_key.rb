class ChangeBestAnswerForeignKey < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :questions, column: :best_answer_id
    add_foreign_key :questions, :answers, column: :best_answer_id, on_delete: :nullify
  end
end
