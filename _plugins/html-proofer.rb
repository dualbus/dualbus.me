# <https://alexwlchan.net/2019/02/checking-jekyll-sites-with-htmlproofer/>
require 'html-proofer'

# <https://github.com/gjtorikian/html-proofer>
options = {
  check_external_hash: true,
  check_favicon: true,
  check_opengraph: true,
  check_html: true,
  validation: {
    # report_invalid_tags: true, # FIXME:
    report_missing_names: true,
  },
  check_img_http: true,
  # enforce_https: true, # FIXME:
}

Jekyll::Hooks.register :site, :post_write do |site|
  HTMLProofer.check_directory(site.config['destination'], options).run
end
