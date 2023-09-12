# frozen_string_literal: true

module RecipesHelper
  def notice_message
    url = Rails.application.routes.recognize_path(request.referrer)
    flash.delete(:notice) unless %w[index show new edit update
                                    destroy].include?(url[:action]) && url[:controller] == 'recipes'
  end
end
