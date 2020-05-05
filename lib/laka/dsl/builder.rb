module Laka::Dsl
  class Builder
    def initialize(deployment, blueprint_root, path)
      @deployment, @blueprint_root, @path = deployment, blueprint_root, path
    end

    def build
      builder = if @path.include?("config.rb")
                  Config.new(@deployment, @blueprint_root, @path)
                else
                  Template.new(@deployment, @blueprint_root, @path)
                end
      builder.build
    end

    def self.build_all(deployment)
      blueprint_root = "app/blueprints/#{deployment}"
      Dir.glob("#{blueprint_root}/**/*.rb").each do |full_path|
        next unless File.file?(full_path)
        builder = new(deployment, blueprint_root, full_path)
        builder.build
      end
    end
  end
end
