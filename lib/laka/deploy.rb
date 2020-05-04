module Laka
  class Deploy < Base
    def run
      @blueprint_root = "app/blueprints/#{@deployment}"

      operation = exist? ? update : create
      waiter = Waiter.new(operation)
      waiter.run
      Resources.new(@options).run
    end

    def update
      new_deployment = GDM::Deployment.new(target: target, name: @deployment, fingerprint: deployment.fingerprint)
      deployment_manager.update_deployment(project, @deployment, new_deployment)
    end

    def create
      new_deployment = GDM::Deployment.new(target: target, name: @deployment)
      deployment_manager.insert_deployment(project, new_deployment)
    end

    def target
      content = Dsl::Builder.new(@deployment, @blueprint_root).build
      configuration = {config: {content: content}}
      GDM::TargetConfiguration.new(configuration)
    end

    def deployment
      deployment_manager.get_deployment(project, @deployment)
    end

    def exist?
      deployment
      true
    rescue Google::Apis::ClientError => e
      raise unless e.message.include?("not found")
      false
    end
  end
end
