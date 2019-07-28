require 'active_support/core_ext/string/output_safety'
require 'open-uri'

module PuppetPdf
  module Helpers
    module View
      def puppet_stylesheet_link_tag(asset)
        url = asset_url(asset)
        asset_content = OpenURI.open_uri(url, &:read)
        "<style type='text/css'>#{asset_content}</style>".html_safe
      end
    end
  end
end
