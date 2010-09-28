class QuestionsController < ApplicationController
  actions :new, :create, :update, :edit, :destroy

  def search
    @questions = Question.search(params[:query],
      :rank_mode      => :wordcount,
      :sort_mode      => :extended,
      :order          => '@relevance DESC, answered_at DESC',
      :field_weights  => { :text => 2, :answer => 1 }
    )
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