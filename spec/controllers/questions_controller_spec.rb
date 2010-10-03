require 'spec_helper'

describe QuestionsController do

  describe "#setup_page_if_exists filter" do

    it "does nothing when there's no :page parameter" do
      get 'queue'
      request.params.should_not have_key(:page)
    end

    it "uses valid :page parameter" do
      get 'queue', :page => '100'
      request.params[:page].should == 100
    end

    it "defaults page to 1 otherwise" do
      get 'queue', :page => '-100'
      request.params[:page].should == 1

      get 'queue', :page => 'ill-formed'
      request.params[:page].should == 1

      get 'queue', :page => '0'
      request.params[:page].should == 1
    end

  end

  describe "#create" do

    it "redirects to #new" do
      post 'create', :question => {:text => 'whatever'}
      flash[:notice].should_not be_nil
      response.should redirect_to new_question_path
    end

  end

  describe "#update" do

    it "redirects to #answered" do
      question = Factory.create(:question)
      post 'update', :id => question.id, :question => {:answer => 'whatever'}
      flash[:notice].should_not be_nil
      response.should redirect_to answered_questions_path
    end

  end

  describe "#destroy" do

    it "redirects back" do
      location = 'http://askmeplease.ru/special/zone'
      @request.env['HTTP_REFERER'] = location
      question = Factory.create(:question)
      delete 'destroy', :id => question.id
      flash[:notice].should_not be_nil
      response.should redirect_to location
    end

    it "redirects to / if there's no HTTP_REFERER" do
      location = root_url
      @request.env['HTTP_REFERER'] = ''
      question = Factory.create(:question)
      delete 'destroy', :id => question.id
      flash[:notice].should_not be_nil
      response.should redirect_to location

      @request.env['HTTP_REFERER'] = nil
      question = Factory.create(:question)
      delete 'destroy', :id => question.id
      flash[:notice].should_not be_nil
      response.should redirect_to location
    end

  end

  describe "#search" do

    it "handles Riddle::ConnectionError (using #total_entries, which immediately performs query)" do
      @search_results = mock('search_results')
      @search_results.stub!(:total_entries).and_raise(Riddle::ConnectionError)
      Question.should_receive(:search).and_return(@search_results)

      get 'search', :search => {:query => 'whatever'}
      response.status.should == 200
      search = assigns(:search)

      search.errors[:base].should include search.errors.generate_message(:base, :unavailable)
    end

    it "handles Riddle::ResponseError" do
      Question.should_receive(:search).and_raise(Riddle::ResponseError)

      get 'search', :search => {:query => 'whatever'}
      response.status.should == 200
      search = assigns(:search)

      search.errors[:base].should include search.errors.generate_message(:base, :unavailable)
    end

  end

end