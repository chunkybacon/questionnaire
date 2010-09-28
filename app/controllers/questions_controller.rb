class QuestionsController < ApplicationController
  actions :new, :create, :update, :destroy

  def search
    
  end

  def answer
    @question = Question.find(params[:id])
  end

  def queue
    @questions = Question.queue.
      order('created_at DESC').
      paginate(:per_page => 5, :page => params[:page])
  end

  def answered
    @questions = Question.answered.
      order('answered_at DESC').
      paginate(:per_page => 5, :page => params[:page])
  end

  def update
    super do |format|
      format.html { redirect_to answered_questions_path }
    end
  end

  def create
    super do |format|
      format.html { redirect_to new_question_path }
    end
  end

  def destroy
    super do |format|
      format.html { redirect_to :back }
    end
  end

end