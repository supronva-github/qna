module LinksHelper
  def display_link(link)
    if link.gist?
      gist_service = GistService.new(link.url)
      gist = gist_service.call

      content_tag :li, class: 'gist-link' do
        gist[:files].each do |file_name, file_data|
          concat content_tag(:h4, file_data[:filename])
          concat content_tag(:pre, file_data[:content])
        end
      end
    else
      content_tag :li do
        link_to link.name, link.url
      end
    end
  end
end
