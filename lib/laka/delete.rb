module Laka
  class Delete < Base
    def run
      gcloud("delete #{@deployment} --config config.yaml -q")
    end
  end
end
