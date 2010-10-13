module ThinkingSphinx
  class Search
    def excerpt_for(string, *args)
      opts, model = args.extract_options!, args.shift

      if model.nil? && one_class
        model ||= one_class
      end

      populate
      client.excerpts(opts.update(
        :docs   => [string],
        :words  => results[:words].keys.join(' '),
        :index  => options[:index] || "#{model.source_of_sphinx_index.sphinx_name}_core"
      )).first
    end
  end
end