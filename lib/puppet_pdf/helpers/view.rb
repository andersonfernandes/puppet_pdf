require 'active_support/core_ext/string/output_safety'
require 'open-uri'

module PuppetPdf
  module Helpers
    module View
      def puppet_stylesheet_link_tag(asset)
        asset_tag = <<~TAG
          <style type='text/css'>
            #{asset_content(asset)}
          </style>
        TAG

        asset_tag.html_safe
      end

      def puppet_javascript_script_tag(asset)
        asset_tag = <<~TAG
          <script type='application/javascript'>
            #{asset_content(asset)}
          </script>
        TAG

        asset_tag.html_safe
      end

      private

      def asset_content(asset)
        url = asset_url(asset)
        OpenURI.open_uri(url, &:read)
      end
    end
  end
end
