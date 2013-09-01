
require "spec_helper"
require "district/bundle_config"

describe BundleConfig do
  let(:config)        { "./spec/fixtures/config" }
  let(:bundle_config) { BundleConfig.new(config) }

  before do
    FileUtils.copy("./spec/fixtures/default", config)
  end

  describe "#clean_local" do
    context "without gems in args" do
      it "clean all gem from file" do
        bundle_config.clean_local
        bundle_config = File.read(config)
        expect(bundle_config).to eql("no local gem on this line\n")
      end
    end

    context "with gem in args" do
      it "clean only gems specify in args from file" do
        bundle_config.clean_local gems: ["test_2", "test_4"]
        bundle_config = File.read(config)
        expect(bundle_config).to eql("BUNDLE_LOCAL__TEST: /test\nno local gem on this line\nBUNDLE_LOCAL__TEST_3: /test_3\n")
      end
    end
  end

  describe "#add_local" do
    it "add all personal gem to bundle config file" do
      bundle_config.add_local gems: ["rails", "bundler"], lib_dir: "/opt"
      bundle_config = File.read(config)
      expect(bundle_config).to include("BUNDLE_LOCAL__RAILS: /opt/rails")
      expect(bundle_config).to include("BUNDLE_LOCAL__BUNDLER: /opt/bundle")
    end
  end
end
