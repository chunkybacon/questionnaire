class Question < ActiveRecord::Base

  validates_length_of   :text   , :in => 5..1000
  validates_length_of   :answer , :in => 5..3000, :allow_nil => true

  scope :answered , where('answer IS NOT NULL')
  scope :queue    , where('answer IS NULL')

  def answer=(value)
    return if value.blank?
    write_attribute :delta        , true
    write_attribute :answer       , value
    write_attribute :answered_at  , current_time_from_proper_timezone
  end

  define_index do
    where('answered_at IS NOT NULL')
    indexes :text
    indexes :answer
  end

end