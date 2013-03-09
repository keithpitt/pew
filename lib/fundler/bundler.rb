module Fundler
  class Bundler
    def self.require(*args)
      puts "Calling Bundler#require with #{args.inspect}"
    end
  end
end
