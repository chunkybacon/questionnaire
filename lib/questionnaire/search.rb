module Questionnaire
  class Search
    include ActiveModel::Validations

    class << self

      attr_reader :defaults
      attr_reader :order_modes

      def configure(&block)
        @match_modes = []
        @order_modes = {}
        yield(self)

        validates_inclusion_of :match_mode, :in => @match_modes, :allow_nil => true
        validates_inclusion_of :order_mode, :in => @order_modes.keys, :allow_nil => true
        validates_length_of :query, :in => @query_range

        self
      end

      def match_modes(*modes)
        modes.empty? ? @match_modes : @match_modes = Riddle::Client::MatchModes.slice(*modes).keys 
      end

      def order_mode(k,v = nil)
        v.nil? ? @order_modes[k] : @order_modes[k] = v
      end

      def query_range(range = nil)
        range.nil? ? @query_range : @query_range = range
      end

    end

    attr_reader :query
    attr_reader :order_mode
    attr_reader :match_mode

    def initialize(opts)
      @query = opts[:query]
      @match_mode = opts[:match_mode].blank? ? nil : opts[:match_mode].to_sym
      @order_mode = opts[:order_mode].blank? ? nil : opts[:order_mode].to_sym
    end

    def options(sp = nil)
      options = {}
      options[:match_mode] = @match_mode
      options[:order] = @order_mode && self.class.order_mode(@order_mode)
      options.update(sp) if sp
      options
    end

  end
end
