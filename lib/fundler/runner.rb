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
        bin_path = File.join gem.bin_path, name

        if File.exist? bin_path
          cmd = %{RUBYOPT="--disable=gem -I#{Fundler.root} -rfundler/setup" #{bin_path} #{args.join " "}}
          p cmd
          Kernel.exec cmd
        end
      end
    end

    def require(path)
      gem = Gem.new(path)

      @gems << gem

      @lookup[gem.name] ||= []
      @lookup[gem.name] << gem

      $:.unshift gem.require_path
      $:.unshift gem.ext_path if gem.has_extensions?
    end
  end
end
