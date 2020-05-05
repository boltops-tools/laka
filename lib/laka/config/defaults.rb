module Laka::Config
  module Defaults
    extend Memoist

    # TODO: parse ~/.config/gcloud/configurations/config_default for speed
    def project
      return "fake-project" if ENV["LAKA_TEST"]
      `gcloud config get-value project`.strip
    end
    memoize :project

    def region
      "us-central1" # TODO: replace hardcoded testing
    end

    def zone
      "us-central1-a" # TODO: replace hardcoded testing
    end

    def google_api_url
      "https://www.googleapis.com/compute/v1"
    end
  end
end
