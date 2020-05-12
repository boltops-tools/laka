module Laka
  class Deploy < Base
    def run
      Generate.new(@options).run

      @blueprint_root = "app/blueprints/#{@deployment}"

      exist? ? update : create
    end

    def update
      gcloud("update #{@deployment} --config config.yaml -q")
    end

    def create
      gcloud("create #{@deployment} --config config.yaml -q")
    end

    def exist?
      deployment_manager.get_deployment(project, @deployment)
      true
    rescue Google::Apis::ClientError => e
      raise unless e.message.include?("not found")
      false
    end
  end
end
