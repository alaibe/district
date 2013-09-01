class District < Struct.new(:bundle_config, :gemfile)

  def localize
    bundle_config.add_local gems: git_gem_from_gemfile
  end

  def delocalize
    bundle_config.clean_local
  end

  private

  def git_gem_from_gemfile
    gemfile.dependencies
  end

end

module Gemnasium
  module Parser
    class Gemfile

      def dependency(match)
        opts = Patterns.options(match["opts"])
        return nil unles git?(match, opts)
        clean!(match, opts)
        name, reqs = match["name"], [match["req1"], match["req2"]].compact
        Bundler::Dependency.new(name, reqs, opts).tap do |dep|
          line = content.slice(0, match.begin(0)).count("\n") + 1
          dep.instance_variable_set(:@line, line)
        end
      end

    end
  end
end
