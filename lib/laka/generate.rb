module Laka
  class Generate < Base
    def run
      @blueprint_root = "app/blueprints/#{@deployment}"

      Dsl::Builder.build_all(@deployment)
    end
  end
end
