module Pew
  module Environment
    class Locked < Base
      def require(path)
        raise path.inspect
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
end
