module Pew
  module Environment
    class All < Base
      def require(name)
        if gem = find(name)
          activate gem
          true
        else
          false
        end
      end

      private

      def lookup(name)
        gem_glob   = File.join Pew.gem_path, "#{name}*"
        found_gems = Dir[gem_glob]

        Gem.new found_gems.first if !found_gems.empty?
      end
    end
  end
end
