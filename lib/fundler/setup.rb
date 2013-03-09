def gem(gem, version)
  require gem
end

class Gem < Fundler::Gem
  class LoadError < StandardError; end
end

FUNDLER = Fundler::Runner.new

Dir["vendor/cache/*.gem"].each do |path|
  FUNDLER.require path
end
