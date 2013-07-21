class District < Struct.new(:gemfile, :bundle_config, :from)

  def localize
    bundle_config.clean_local
    bundle_config.add_local gems: gems, from: path
  end

  def delocalize
    bundle_config.clean_local
  end

end
