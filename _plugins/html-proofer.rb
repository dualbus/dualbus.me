# <https://alexwlchan.net/2019/02/checking-jekyll-sites-with-htmlproofer/>
require 'html-proofer'

Jekyll::Hooks.register :site, :post_write do |site|
  HTMLProofer.check_directory(site.config['destination']).run
end
