module Pew
  class Runner
    attr_accessor :gems, :loaded_specs

    def initialize
      @environment = Environment::All.new
    end

    def find(name)
      @environment.find(name)
    end

    def require(path)
      @environment.require(path)
    end

    def exec(name, args = [])
      bin = nil
      if File.exist?(name)
        bin = name
      else
        @environment.gems.each do |gem|
          path = File.join gem.bindir, name
          bin = path if File.exist? path
        end
      end

      if bin
        Kernel.exec Pew.command_without_rubygems(bin, args)
      else
        puts "Couldnt find #{name} to run"
      end
    end
  end
end
