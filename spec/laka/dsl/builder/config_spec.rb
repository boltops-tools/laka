describe Laka::Dsl::Builder::Config do
  let(:builder)        { described_class.new(deployment, blueprint_root, path) }
  let(:deployment)     { "vm" }
  let(:blueprint_root) { "spec/fixtures/blueprints/vm" }

  context "config" do
    let(:path) { "spec/fixtures/blueprints/vm/config.rb" }
    it "evaluate" do
      result = builder.build
      yaml =<<~EOL
imports:
- vm.jinja
- network.jinja
- firewall.jinja
- compute-engine.jinja
resources:
- name: compute-engine-setup
  type: compute-engine.jinja
      EOL
      expect(result).to eq(yaml)
    end
  end
end
