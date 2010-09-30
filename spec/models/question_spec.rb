require 'spec_helper'

describe Question do

  describe "deal with answered_at timestamp" do

    before(:each) do
      @question = Factory.create(:question)
    end

    it "defaults answered_at to nil" do
      @question.answered_at.should == nil
    end

    describe "on update"

      it "does not update answered_at if there's no changes in answer" do
        c = 1.hour.ago
        @question.update_attributes(:created_at => c)
        @question.answered_at.should be_nil
        @question.created_at.should == c
      end

      it "updates answered_at otherwise" do
        @now = Time.now
        Time.stub(:now).and_return(@now)
        @question.update_attributes(:answer => 'whatever')
        @question.answered_at.should == @now
      end

      it "does not update answered_at twice" do
        @now = Time.now
        Time.stub(:now).and_return(@now)
        @question.update_attributes(:answer => 'whatever')
        @question.answered_at.should == @now

        Time.stub(:now).and_return(@now + 1.hour)
        @question.update_attributes(:answer => 'ooops')
        @question.answered_at.should == @now
      end

  end

  describe "deal with deltas" do

    before(:each) do
      @question = Factory.create(:question)
    end

    it "does not force delta indexing after creation" do
      @question.delta.should == false
    end

    it "forces delta indexing after answering" do
      @question.update_attributes(:answer => 'whatever')
      @question.delta.should == true
    end

    it "forces delta indexing after updating the answer" do
      @question.update_attributes(:answer => 'whatever')
      @question.update_attributes(:answer => 'No way!')
      @question.delta.should == true
    end

    it "forces delta indexing after updating the text" do
      @question.update_attributes(:text => 'No way!')
      @question.delta.should == true
    end

    it "does not force delta indexing after updating not-indexable fields" do
      c = 1.hour.ago
      @question.update_attributes(:created_at => c)
      @question.delta.should == false
      @question.created_at.should == c
    end

  end

end