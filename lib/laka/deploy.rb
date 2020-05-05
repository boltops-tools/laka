ENV['GOOGLE_AUTH_SUPPRESS_CREDENTIALS_WARNINGS'] = '1'

module Laka
  class Deploy < Base
    def run
      Generate.new(@options).run

      @blueprint_root = "app/blueprints/#{@deployment}"

      exist? ? update : create
    end

    def update
      gcloud_deploy("update #{@deployment} --config config.yaml -q")
    end

    def create
      gcloud_deploy("create #{@deployment} --config config.yaml -q")
    end

    def exist?
      deployment_manager.get_deployment(project, @deployment)
      true
    rescue Google::Apis::ClientError => e
      raise unless e.message.include?("not found")
      false
    end


    def gcloud_deploy(command)
      command = "gcloud deployment-manager deployments #{command}"
      puts "=> #{command}"

      dir = "output/blueprints/#{@deployment}"
      puts "Within dir: #{dir}"
      Dir.chdir(dir) do
        success = system(command)
        exit $?.exitstatus unless success
      end
    end
  end
end
