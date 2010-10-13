# http://openmonkey.com/articles/2009/07/thinking-sphinx-rspec-matchers
# http://gist.github.com/21755

module ThinkingSphinxMatchers

  def self.included(group)
    group.send(:include, Helpers)
  end

  class HaveColumnMatcher

    def initialize(subject, *args)
      options = args.extract_options!

      raise ArgumentError if args.empty?

      @subject  = subject
      @indexes  = Array(options[:in])
      @expected = args.map(&:to_sym)
    end

    def matches?(target)

      @target = target

      indexes = @target.sphinx_indexes
      indexes = indexes.select { |i| @indexes.include?(i.name) } unless @indexes.empty?
      return false if indexes.empty?

      indexes.all? { |i|
        i.send(@subject).any? { |thing| thing.columns.any? { |c| c.__path == @expected } }
      }

    end

    def failure_message
      "expected #{@target} to have a column #{@expected.join('.')} in " \
      "#{@subject} of #{@indexes.empty? ? 'all' : @indexes.inspect} indexes, " \
      "but it did not"
    end

    def negative_failure_message
      "expected #{@target} NOT to have a column #{@expected.join('.')} in " \
      "#{@subject} of #{@indexes.empty? ? 'all' : @indexes.inspect} indexes, " \
      "but it did"
    end

  end

  module Helpers

    def have_search_index_for(*args)
      HaveColumnMatcher.new(:fields, *args)
    end

    def have_search_attribute_for(*args)
      HaveColumnMatcher.new(:attributes, *args)
    end

  end

end