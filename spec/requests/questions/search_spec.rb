require 'spec_helper'

describe 'search' do

  self.use_transactional_fixtures = false

  require 'thinking_sphinx/test'
  ThinkingSphinx::Test.init

  before :each do
    Question.destroy_all
    5.times do |i|
      question = Question.create(:text => 'question')
      question.update_attributes(:answer => 'answer')
    end
  end

  before(:each) do
    ThinkingSphinx::Test.start # this will also reindex content
    sleep(0.25)
  end

  it 'respects deleted content' do

    questions = Question.all.to_a

    # ignore Question.delete_in_index, deltas etc
    # because search results should contain at least one nil
    Question.connection.execute("DELETE FROM #{Question.table_name} WHERE id=#{questions.first.id};")

    visit search_questions_url
    fill_in 'query', :with => 'question'
    click_button I18n.t('questions.search.submit')

    response.should be_success
    questions[1...-1].each do |question|
      response.should contain I18n.t('questions.search.show', :id => question.id)
    end

    response.should_not contain I18n.t('questions.search.show', :id => questions.first.id)
    response.should contain I18n.t('questions.search.deleted')

  end

  after(:each) do
    Question.destroy_all
    ThinkingSphinx::Test.stop
  end

end