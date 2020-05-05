# Laka

[![Gem Version](https://badge.fury.io/rb/laka.png)](http://badge.fury.io/rb/laka)

Google Deployment Manager DSL.

## Usage

Generate:

    $ laka generate vm
    Ouput written to output/blueprints/vm/firewall.jinja
    Ouput written to output/blueprints/vm/network.jinja
    Ouput written to output/blueprints/vm/config.yaml
    Ouput written to output/blueprints/vm/vm.jinja
    Ouput written to output/blueprints/vm/compute-engine.jinja
    $

Deploy:

    $ laka deploy vm
    Ouput written to output/blueprints/vm/firewall.jinja
    Ouput written to output/blueprints/vm/network.jinja
    Ouput written to output/blueprints/vm/config.yaml
    Ouput written to output/blueprints/vm/vm.jinja
    Ouput written to output/blueprints/vm/compute-engine.jinja
    => gcloud deployment-manager deployments update vm --config config.yaml -q
    Within dir: output/blueprints/vm
    The fingerprint of the deployment is Z1DTSWUHSN0B8EhHmHNQBA==
    Waiting for update [operation-1588650386322-5a4de7df2f506-e7570d81-ae643ef4]...done.
    Update operation operation-1588650386322-5a4de7df2f506-e7570d81-ae643ef4 completed successfully.
    NAME                   TYPE                 STATE      ERRORS  INTENT
    demo-network           compute.v1.network   COMPLETED  []
    demo-network-firewall  compute.v1.firewall  COMPLETED  []
    vm-1                   compute.v1.instance  COMPLETED  []
    vm-2                   compute.v1.instance  COMPLETED  []
    $

## Example Structure

    $ tree app/blueprints/vm
    app/blueprints/vm
    ├── compute-engine.rb
    ├── config.rb
    ├── firewall.rb
    ├── network.rb
    └── vm.rb

## DSL

app/blueprints/vm/config.rb

```ruby
import(
  "vm",
  "compute-engine",
)
resource(
  name: "compute-engine-setup",
  type: "compute-engine"
)
```

app/blueprints/vm/compute-engine.rb

```ruby
@network_name = "demo-network"

resource("vm-1", "vm",
  machineType: "f1-micro",
  zone: "us-central1-f",
  network: @network_name,
)
resource("vm-2", "vm",
  machineType: "g1-small",
  zone: "us-central1-f",
  network: @network_name,
)
resource(@network_name, "network")
resource("#{@network_name}-firewall", "firewall",
  network: @network_name
)
```

app/blueprints/vm/vm.rb

```ruby
resource(env("name"), "compute.v1.instance",
  zone: properties("zone"),
  machineType: "https://www.googleapis.com/compute/v1/projects/#{env("project")}/zones/#{properties("zone")}/machineTypes/#{properties("machineType")}",
  disks: [
    deviceName: "boot",
    type: "PERSISTENT",
    boot: true,
    autoDelete: true,
    initializeParams: {
      sourceImage: "debian-9"
    }
  ],
  scheduling: {
    preemptible: true,
    automaticRestart: false,
  },
  networkInterfaces: [
    network: ref(properties("network")),
    accessConfigs: [
      name: "External NAT",
      type: "ONE_TO_ONE_NAT"
    ]
  ]
)
```

## Installation

Install with:

    gem install laka

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am "Add some feature"`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
