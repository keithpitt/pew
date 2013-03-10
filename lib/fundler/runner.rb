module Fundler
  class Runner
    attr_accessor :gems, :loaded_specs

    def initialize
      @gems         = []
      @loaded_specs = {}
    end

    def find(name)
      @loaded_specs[name]
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

      if gem.installed?
        @gems << gem

        unless @loaded_specs[gem.name]
          gem.require_paths.each do |path|
            $:.unshift path
          end

          @loaded_specs[gem.name] = gem
        end
      end
    end
  end
end
