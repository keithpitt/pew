module Fundler
  class Bundler
    def self.require(*args)
      FUNDLER.gems.each do |gem|
        if gem.meta_data['railties']
          name = gem.meta_data['name']
          begin
            Kernel.require name
          rescue LoadError
            # puts "Could not autoload load #{name}"
          end
        end
      end
      puts "Calling Bundler#require with #{args.inspect}"
    end
  end
end
