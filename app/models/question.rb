class Question < ActiveRecord::Base

  stripper = lambda { |s| s && s.strip }

  validates_length_of   :text   , :in => 5..1000, :tokenizer => stripper
  validates_length_of   :answer , :in => 5..3000, :tokenizer => stripper, :allow_nil => true

  scope :answered , where('answer IS NOT NULL')
  scope :queue    , where('answer IS NULL')

  before_create do
    self.delta = false
    true
  end

  before_update do
    self.answered_at = current_time_from_proper_timezone if answer && !answered_at
    self.delta = false unless text_changed? || answer_changed?
  end

  define_index do
    where('answered_at IS NOT NULL')
    indexes :text
    indexes :answer
    has :answered_at, :created_at
    set_property :delta => :delayed
  end

end
