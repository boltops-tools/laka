describe Laka::Dsl::Builder do
  let(:builder) { described_class.new(blueprint_root) }
  let(:blueprint_root) { "spec/fixtures/blueprints/vm" }

  context "vm" do
    it "evaluate" do
      builder.evaluate
      pp builder.resources
    end
  end
end
