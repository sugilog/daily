module ApplicationHelper
  def link_to_without_turbolink(*args)
    html_options = args.extract_options!
    html_options.update("data-no-turbolink" => true)
    args << html_options

    if block_given?
      link_to *args do
        yield
      end
    else
      link_to *args
    end
  end
end
