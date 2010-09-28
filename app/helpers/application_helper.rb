module ApplicationHelper

  def will_paginate(collection, opts = {})
    opts[:previous_label] ||= I18n.t('will_paginate.previous_label')
    opts[:next_label] ||= I18n.t('will_paginate.next_label')
    super
  end

end
