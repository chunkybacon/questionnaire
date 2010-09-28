class SearchOptions
  attr_reader :query

  # TODO: options

  def self.from_hash(hsh)
    return nil if hsh.blank? || hsh[:query].blank?
    self.new(hsh[:query])
  end

  def initialize(query, opts = {})
    @query = query
  end

end
