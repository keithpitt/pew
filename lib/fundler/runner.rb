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

        Kernel.exec "#{bin_path} #{args.join " "}" if File.exist? bin_path
      end
    end

    def require(path)
      gem = Gem.new(path)

      @gems << gem

      @lookup[gem.name] ||= []
      @lookup[gem.name] << gem

      Fundler.append_load_path gem.require_path
    end
  end
end
