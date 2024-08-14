class AnswersController < ApplicationController
  before_action :find_question

  def new
    binding.pry
    @answer = @question.answers.new
  end


  def find_question
    binding.pry
    @question = Question.find(params[:question_id])
  end
end
