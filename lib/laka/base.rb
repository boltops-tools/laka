module Laka
  class Base
    include Laka::Config::Defaults
    include GcpServices
    extend Memoist

    def initialize(options={})
      @options = options
      @deployment = @options[:deployment]
    end
  end
end
