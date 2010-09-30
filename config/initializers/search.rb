require 'thinking_sphinx/deltas/delayed_delta'
require 'lib/questionnaire/search'
require 'lib/questionnaire/ts'

ThinkingSphinx.suppress_delta_output = true

Questionnaire::Search.configure do |c|

  c.order_mode :r   , '@relevance DESC, answered_at DESC'
  c.order_mode :a   , 'answered_at DESC, @relevance DESC'
  c.order_mode :c   , 'created_at DESC, @relevance DESC'

  #--
  #
  # :all
  # This is the default for Thinking Sphinx,
  # and requires a document to have every given
  # word somewhere in its fields.
  #
  # :any
  # This will return documents that include
  # at least one of the keywords in their fields.
  #
  # :phrase
  # This matches all given words together in one place,
  # in the same order. It’s just the same as wrapping a
  # Google search in quotes.
  #
  #++

  c.match_modes :all, :any, :phrase

  c.query_range 5..100

end
