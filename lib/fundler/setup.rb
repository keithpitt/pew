require_relative "../fundler"

def gem(*args)
  require gem.first
end

class Gem < Fundler::Gem
  class LoadError < StandardError; end
end

class Bundler < Fundler::Bundler
end

FUNDLER = Fundler::Runner.new

Dir["vendor/cache/*.gem"].each do |path|
  FUNDLER.require path
end
