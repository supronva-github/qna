class AnswersController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]

  def new; end

  def show; end

  def create
    @answer = question.answers.new(answer_params)
    @answer.author = current_user
    @answer.save
  end

  def destroy
    answer.destroy if current_user.author_of?(answer)
  end

  def update
    answer.update(answer_params)
    @question = answer.question
  end

  private

  def answer
    @answer ||= params[:id] ? Answer.find(params[:id]) : question.answers.new
  end

  def question
    @question ||= Question.find(params[:question_id])
  end

  helper_method :question, :answer

  def answer_params
    params.require(:answer).permit(:body)
  end
end
