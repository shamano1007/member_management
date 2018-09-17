module AssetsHelper
  def controller_js_include
    path = "controllers/#{controller_path}"
    script = "#{Rails.root}/app/assets/javascripts/#{path}"
    javascript_include_tag path if controller_path_exists?(script, %i[js coffee])
  end

  def controller_css_include
    path = "controllers/#{controller_path}"
    script = "#{Rails.root}/app/assets/stylesheets/#{path}"
    stylesheet_link_tag path if controller_path_exists?(script, %i[scss])
  end

  private

  def controller_path_exists?(script, extensions)
    extensions.any? { |extension| File.exist?("#{script}.#{extension}") }
  end
end
