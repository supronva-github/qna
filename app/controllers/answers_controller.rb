class AnswersController < ApplicationController
  def new
    @answer = question.answers.new
  end

  def show
  end

  def create
    @answer = question.answers.new(answer_params)

    if @answer.save
      redirect_to @answer
    else
      render :new
    end
  end

  private

  def question
    @question ||= Question.find(params[:question_id])
  end

  helper_method :question

  def answer_params
    params.require(:answer).permit(:body)
  end
end
