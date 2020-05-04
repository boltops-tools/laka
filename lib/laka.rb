$:.unshift(File.expand_path("../", __FILE__))
require "laka/version"
require "memoist"
require "rainbow/ext/string"

require "laka/autoloader"
Laka::Autoloader.setup

module Laka
  class Error < StandardError; end
end
