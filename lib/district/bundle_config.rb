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
    remove_line_which_match LOCAL, gems
  end
  
  def add_local(options = {})
    gems = options.delete(:gems)
    from = options.delete(:from)
  end

  private

  def remove_line_which_match(matcher, gems)
    path = @file.path
    tmp  = Tempfile.new("bundle_config")

    @file.each_line do |line|
      if gems
        gem_name = extract_gem_name_from(line)
        tmp.write(line) unless line.match(matcher) && gems.include?(gem_name)
      else
        tmp.write(line) unless line.match(matcher)
      end
    end

    tmp.close
    FileUtils.copy(tmp.path, path)
    tmp.unlink
  end

  def extract_gem_name_from(bundle_line)
    bundle_line.split('/').last
  end
end
