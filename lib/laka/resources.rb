module Laka
  class Resources < Base
    def run
      puts "Listing resources for deployment #{@deployment}"
      resp = deployment_manager.list_resources(project, @deployment)
      resp.resources.each do |resource|
        resource = deployment_manager.get_resource(project, @deployment, resource.name)
        puts "#{resource.name} #{resource.type}"
      end
    end
  end
end
