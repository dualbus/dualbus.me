# `html-proofer` (plugin) does not seem to process the `LANG' environment
# variable, or the `charset` setting inside `_config.yml'. The following fixes
# that.
#   <https://makandracards.com/makandra/41250-ruby-s-default-encodings-can-be-unexpected>
#   <https://seenukarthi.com/pipeline/2017/06/22/jekyll-github-cicd-bitbucket-pipeline/>
Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

source 'https://rubygems.org' do
  gem 'html-proofer'
  gem 'jekyll'
end
