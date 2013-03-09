module Fundler
  class Runner
    attr_accessor :gems

    def initialize
      @gems   = []
      @lookup = {}
    end

    def find(name)
      @lookup[name].first
    end

    def exec(name, args = [])
      @gems.each do |gem|
        bin = File.join gem.bindir, name
        Kernel.exec Fundler.command_without_rubygems(bin, args) if File.exist? bin
      end
    end

    def require(path)
      gem = Gem.new(path)

      @gems << gem

      @lookup[gem.name] ||= []
      @lookup[gem.name] << gem

      $:.unshift *gem.load_paths if gem.installed?
    end
  end
end
