class AnswersController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]

  def new; end

  def show; end

  def create
    @answer = question.answers.new(answer_params)
    @answer.author = current_user

    if @answer.save
      redirect_to @answer, notice: 'Your answer successfully created.'
    else
      render :new
    end
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
