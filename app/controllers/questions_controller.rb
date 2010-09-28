class QuestionsController < ApplicationController
  actions :new, :create, :update, :edit, :destroy

  def search
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

  create!   { new_question_path }
  update!   { answered_questions_path }
  destroy!  { :back }

end