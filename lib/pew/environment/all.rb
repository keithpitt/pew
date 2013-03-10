module Pew
  module Environment
    class All < Base
      def find(name)
        gem_glob   = File.join Pew.gem_path, "#{name}*"
        found_gems = Dir[gem_glob]

        Gem.new found_gems.first if !found_gems.empty?
      end

      def require(name)
        if gem = find(name)
          activate gem
          true
        else
          false
        end
      end
    end
  end
end
