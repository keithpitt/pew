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
      bin = nil
      if File.exist?(name)
        bin = name
      else
        @gems.each do |gem|
          path = File.join gem.bindir, name
          bin = path if File.exist? path
        end
      end

      if bin
        Kernel.exec Fundler.command_without_rubygems(bin, args)
      else
        puts "Couldnt find #{name} to run"
      end
    end

    def require(path)
      gem = Gem.new(path)

      @gems << gem

      @lookup[gem.name] ||= []
      @lookup[gem.name] << gem

      if gem.installed?
        gem.require_paths.each do |path|
          unless $:.include?(path)
            p path
            $:.unshift path
          end
        end
      end
    end
  end
end
