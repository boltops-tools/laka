module Laka::Dsl::Expander::Compute
  class Instance < Base
    include Laka::Config::Defaults

    def expand
      network!
      sourceImage!
      machineType!
      @props
    end

    def sourceImage!
      @props[:disks].each do |disk|
        sourceImage = disk.dig(:initializeParams, :sourceImage)
        next unless sourceImage
        next if sourceImage.include?(google_api_url) # noop

        image = case sourceImage
                when /debian/
                  "#{google_api_url}/projects/debian-cloud/global/images/family/#{sourceImage}"
                else
                  sourceImage
                end
        # update
        disk[:initializeParams][:sourceImage] = image
      end
    end

    def network!
      networkInterfaces = @props[:networkInterfaces]
      networkInterfaces.each do |interface|
        network = interface[:network]
        next unless network
        next if network.include?(google_api_url) # noop

        interface[:network] = "#{google_api_url}/projects/#{project}/global/networks/#{network}"
      end
    end

    def machineType!
      machineType = @props[:machineType]
      return unless machineType
      return if machineType.include?(google_api_url) # noop
      @props[:machineType] = "#{google_api_url}/projects/#{project}/zones/#{zone}/machineTypes/#{machineType}"
    end
  end
end
