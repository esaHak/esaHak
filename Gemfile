# =============================================================================
# GEMFILE - Ruby Dependencies
# =============================================================================
# This file tells GitHub Pages which Jekyll version and plugins to use.

source "https://rubygems.org"

# Use a newer Jekyll that's compatible with Ruby 3.4+
gem "jekyll", "~> 4.3"

# Required for Ruby 3.4+
gem "csv"
gem "base64"
gem "bigdecimal"

# Plugins
group :jekyll_plugins do
  gem "jekyll-feed"
  gem "jekyll-polyglot"
  gem "jekyll-seo-tag"
  gem "jekyll-sitemap"
end

# Windows and JRuby does not include zoneinfo files
platforms :mingw, :x64_mingw, :mswin, :jruby do
  gem "tzinfo", ">= 1", "< 3"
  gem "tzinfo-data"
end

# Performance booster for watching directories on Windows
gem "wdm", "~> 0.1", :platforms => [:mingw, :x64_mingw, :mswin]

# Lock http_parser.rb for JRuby
gem "http_parser.rb", "~> 0.6.0", :platforms => [:jruby]
