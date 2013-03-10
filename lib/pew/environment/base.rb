module Pew
  module Environment
    class Base
      attr_accessor :gems, :loaded_specs

      def initialize
        @loaded_specs = {}
      end

      def find(name)
        @loaded_specs[name]
      end

      def activate(gem)
        gem.activate
        @loaded_specs[gem.name] = gem
      end
    end
  end
end
