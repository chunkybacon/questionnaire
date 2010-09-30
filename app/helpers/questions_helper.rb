module QuestionsHelper

  def match_mode_options
    options = {}
    Questionnaire::Search.match_modes.each do |mode|
      translation = I18n.t("questions.search.match_modes.#{mode}")
      options[translation] = mode
    end
    options
  end

  def order_mode_options
    options = {}
    Questionnaire::Search.order_modes.keys.each do |mode|
      translation = I18n.t("questions.search.order_modes.#{mode}")
      options[translation] = mode
    end
    options
  end

end
