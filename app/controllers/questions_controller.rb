class QuestionsController < ApplicationController
  actions :new, :create, :update, :edit, :destroy

  responders :flash

  def search
    return if params[:search].blank?

    @search = Questionnaire::Search.new(params[:search])
    return unless @search.valid?

    @questions = Question.search(@search.query, @search.options(
      :rank_mode      => :wordcount,
      :field_weights  => {:text => 2, :answer => 1},
      :per_page       => 5,
      :page           => params[:page]
      ))

    @questions.total_entries

  rescue Riddle::ConnectionError
    @search.errors.add(:base, :unavailable)
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
