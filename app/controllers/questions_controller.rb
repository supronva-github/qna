class QuestionsController < ApplicationController
  include Voted

  before_action :authenticate_user!, except: %i[index show]

  def index
    @questions = Question.all
  end

  def show
    @answer ||= question.answers.new
    @best_answer = @question.best_answer
		@other_answers = @question.answers.where.not(id: @question.best_answer_id).by_add
    @answer.links.new
  end

  def new
    question.links.build
    question.build_badge
  end

  def edit; end

  def create
    @question = current_user.owner_questions.new(question_params)

    if @question.save
      redirect_to @question, notice: 'Your question successfully created.'
    else
      @question.links.build if @question.links.empty?
      @question.build_badge if @question.badge.nil?
      render :new
    end
  end

  def update
    question.update(question_params) if current_user.author_of?(question)
  end

  def destroy
    if current_user.author_of?(question)
      question.destroy
      redirect_to questions_path, notice: 'Question successfully deleted.'
    else
      redirect_to question_path, notice: 'Only author can delete question.'
    end
  end

  private

  def question
    @question ||= params[:id] ? Question.with_attached_files.find(params[:id]) : Question.new
  end

  helper_method :question

  def question_params
    params.require(:question).permit(:title, :body, files: [],
                                    links_attributes: [:name, :url, :id, :_destroy],
                                    badge_attributes: [:name, :image, :id])
  end
end
