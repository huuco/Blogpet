module ApplicationHelper
  include Pagy::Backend
  include Pagy::Frontend

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mapping[:user]
  end

  def pagy_nav_tailwind(pagy)
    return unless pagy.pages > 1

    content_tag(:nav, class: "flex justify-center items-center space-x-2 my-4") do
      safe_join([
        pagy_prev_link(pagy),
        pagy_numbered_links(pagy),
        pagy_next_link(pagy)
      ].flatten)
    end
  end

  private

  def pagy_prev_link(pagy)
    link_or_span('&laquo; Prev', pagy.prev, pagy)
  end

  def pagy_next_link(pagy)
    link_or_span('Next &raquo;', pagy.next, pagy)
  end

  def pagy_numbered_links(pagy)
    pagy.series.map do |item|
      case item
      when Integer
        link_to(item, pagy_url_for(pagy, item), class: link_class)
      when String
        content_tag(:span, item, class: disabled_class)
      else
        content_tag(:span, "...", class: disabled_class)
      end
    end
  end

  def link_or_span(text, condition, pagy)
    if condition
      link_to(pagy_url_for(pagy, condition), class: link_class) { raw(text) }
    else
      content_tag(:span, raw(text), class: disabled_class)
    end
  end

  def link_class
    "px-3 py-2 rounded-md text-sm font-medium text-gray-700 bg-white hover:bg-gray-50"
  end

  def disabled_class
    "px-3 py-2 rounded-md text-sm font-medium text-gray-400 bg-white cursor-not-allowed"
  end
end
