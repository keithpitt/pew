require_relative "../fundler"

def gem(*args)
  # Not sure whether I have to do anything with this command yet.
  # Maybe I can just ignore it?
  # See activerecord-4.0.0.beta1/lib/active_record/connection_adapters/sqlite3_adapter.rb for
  # an example of how its used.
end

class Gem < Fundler::Gem
  class Specification; end
  class LoadError < StandardError; end

  def self.available?(gem_name, version_string)
    FUNDLER.loaded_specs[gem_name]
  end

  def self.loaded_specs
    FUNDLER.loaded_specs
  end
end

class Bundler < Fundler::Bundler
end

FUNDLER = Fundler::Runner.new

Dir["vendor/cache/*.gem"].each do |path|
  FUNDLER.require path
end
