module Pew
  class Locked
    attr_accessor :gems, :loaded_specs

    def initalize
    end

    def find(name)
      @loaded_specs[name]
    end

    def require(path)
      gem = Gem.new(path)
      @gems << gem

      if gem.installed?
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
