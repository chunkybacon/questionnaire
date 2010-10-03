#http://openmonkey.com/articles/2009/07/thinking-sphinx-rspec-matchers

Spec::Matchers.define(:have_search_index_for) do |*field_names|

  description do
    "have a search index for #{field_names.join('.')}"
  end

  match do |model|
    all_fields = field_names.dup
    first_field = all_fields.pop

    model.sphinx_indexes.first.fields.select { |field|
      field.columns.length == 1 &&
        field.columns.first.__stack == all_fields.map { |s| s.to_sym } &&
        field.columns.first.__name == first_field.to_sym
    }.length == 1
  end

end

Spec::Matchers.define(:have_search_attribute_for) do |*attr_names|

  description do
    "have a search attribute for #{attr_names.join('.')}"
  end

  match do |model|
    all_attrs = attr_names.dup
    first_attr = all_attrs.pop

    model.sphinx_indexes.first.attributes.select { |a|
      a.columns.length == 1 &&
        a.columns.first.__stack == all_attrs.map { |s| s.to_sym } &&
        a.columns.first.__name == first_attr.to_sym
    }.length == 1
  end

end