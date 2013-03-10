module Pew
  module Environment
    class Base
      attr_accessor :gems, :loaded_specs

      def initialize
        @gems         = []
        @loaded_specs = {}
      end

      def find(name)
        @loaded_specs[name]
      end

      def activate(gem)
        gem.activate
        @loaded_specs[gem.name] = gem
        @gems << gem
      end
    end
  end
end
