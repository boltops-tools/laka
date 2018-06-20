$:.unshift(File.expand_path("../", __FILE__))
require "laka/version"

module Laka
  autoload :Help, "laka/help"
  autoload :Command, "laka/command"
  autoload :CLI, "laka/cli"
  autoload :Sub, "laka/sub"
  autoload :Completion, "laka/completion"
  autoload :Completer, "laka/completer"
end
