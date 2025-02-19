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
    answer.remove_with_reset if current_user.author_of?(answer)
  end

  def update
    answer.update(answer_params)
    @question = answer.question
  end

  def best
    answer.mark_as_best
  end

  private

  def answer
    @answer ||= params[:id] ? Answer.with_attached_files.find(params[:id]) : question.answers.new
  end

  def question
    @question ||= Question.find(params[:question_id])
  end

  helper_method :question, :answer

  def answer_params
    params.require(:answer).permit(:body, files: [],
                                    links_attributes: [:name, :url, :id, :_destroy])
  end
end
