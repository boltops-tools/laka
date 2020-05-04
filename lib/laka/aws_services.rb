require "aws-sdk-ec2"

module Laka
  module AwsServices
    extend Memoist

    def ec2
      Aws::EC2::Client.new
    end
    memoize :ec2
  end
end
