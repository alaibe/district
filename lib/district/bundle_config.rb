class BundleConfig
  
  DEFAULT_PATH = "#{ENV['HOME']}/.bundle/config"

  def initialize(path = nil)
    path ||= DEFAULT_PATH

    @file = File.open(path, "r+")
  end

  def clean_local
  	BUNDLE_LOCAL__ZAYNAR_COMMON: /Users/anthony/dev/zaynar_common
  end

  def add_local(options = {})
  	gems = options.delete(:gems)
  	from = options.delete(:from)
  end
end