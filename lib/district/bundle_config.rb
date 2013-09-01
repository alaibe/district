require "fileutils"
require "tempfile"

class BundleConfig

  DEFAULT_PATH = "#{ENV['HOME']}/.bundle/config"
  LOCAL        = "BUNDLE_LOCAL"

  def initialize(path = nil)
    path ||= DEFAULT_PATH

    @file = File.open(path, "r+")
  end

  def clean_local(options = {})
    gems = options.delete(:gems)
    remove_line_which_match gems
  end

  def add_local(options = {})
    gems    = options.delete(:gems)
    lib_dir = options.delete(:lib_dir)

    gems.each { |gem|  add_new_gem(gem, lib_dir)}
    @file.close
  end

  private

  def remove_line_which_match(gems)
    path = @file.path
    tmp  = Tempfile.new("bundle_config")

    @file.each_line do |line|
      if gems
        gem_name = extract_gem_name_from(line)
        tmp.write(line) unless line.match(LOCAL) && gems.include?(gem_name.strip)
      else
        tmp.write(line) unless line.match(LOCAL)
      end
    end

    tmp.close
    FileUtils.copy(tmp.path, path)
    tmp.unlink
  end

  def add_new_gem(gem, lib_dir)
    @file.write "\n#{LOCAL}__#{gem.upcase}: #{lib_dir}/#{gem}\n"
  end

  def extract_gem_name_from(bundle_line)
    bundle_line.split('/').last
  end
end
