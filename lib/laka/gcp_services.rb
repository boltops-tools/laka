require 'google/apis/deploymentmanager_v2'
require 'googleauth'

GDM = Google::Apis::DeploymentmanagerV2

module Laka
  module GcpServices
    extend Memoist

    def deployment_manager
      manager = GDM::DeploymentManagerService.new
      authorization = Google::Auth.get_application_default([GDM::AUTH_CLOUD_PLATFORM])
      manager.authorization = authorization
      manager
    end
    memoize :deployment_manager
  end
end
