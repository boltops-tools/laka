describe Laka::Dsl::Builder::Template do
  let(:builder)        { described_class.new(deployment, blueprint_root, path) }
  let(:deployment)     { "vm" }
  let(:blueprint_root) { "spec/fixtures/blueprints/vm" }

  context "vm" do
    let(:path) { "spec/fixtures/blueprints/vm/vm.rb" }
    it "evaluate" do
      result = builder.build
      yaml =<<~EOL
resources:
- name: "{{ env['name'] }}"
  type: compute.v1.instance
  properties:
    zone: "{{ properties['zone'] }}"
    machineType: https://www.googleapis.com/compute/v1/projects/fake-project/zones/us-central1-a/machineTypes/{{
      properties['machineType'] }}
    disks:
    - deviceName: boot
      type: PERSISTENT
      boot: true
      autoDelete: true
      initializeParams:
        sourceImage: https://www.googleapis.com/compute/v1/projects/debian-cloud/global/images/family/debian-9
    scheduling:
      preemptible: true
      automaticRestart: false
    networkInterfaces:
    - network: https://www.googleapis.com/compute/v1/projects/fake-project/global/networks/$(ref.{{
        properties['default'] }}.selfLink)
      accessConfigs:
      - name: External NAT
        type: ONE_TO_ONE_NAT
      EOL
      expect(result).to eq(yaml)
    end
  end

  context "network" do
    let(:path) { "spec/fixtures/blueprints/vm/network.rb" }
    it "evaluate" do
      result = builder.build
      yaml =<<~EOL
resources:
- name: "{{ env['name'] }}"
  type: compute.v1.network
  properties:
    routingConfig:
      routingMode: REGIONAL
    autoCreateSubnetworks: true
      EOL
      expect(result).to eq(yaml)
    end
  end

  context "firewall" do
    let(:path) { "spec/fixtures/blueprints/vm/firewall.rb" }
    it "evaluate" do
      result = builder.build
      yaml =<<~EOL
resources:
- name: "{{ env['name'] }}"
  type: compute.v1.firewall
  properties:
    network: "$(ref.{{ properties['network'] }}.selfLink)"
    sourceRanges:
    - 0.0.0.0/0
    allowed:
    - IPProtocol: TCP
      ports:
      - '80'
      EOL
      expect(result).to eq(yaml)
    end
  end
end
