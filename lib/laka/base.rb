module Laka
  class Base
    include GcpServices
    extend Memoist

    def initialize(options={})
      @options = options
      @deployment = @options[:deployment]
    end

    def project
      `gcloud config get-value project`.strip
    end
    memoize :project
  end
end
