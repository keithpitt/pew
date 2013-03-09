module Fundler
  class Compiler
    attr_accessor :gem

    def initialize(gem)
      @gem = gem
    end

    def gem_path
      gem.gem_path
    end

    def compile
      gem.ext_paths.each do |ext_path|
        extconf = File.join ext_path, "extconf.rb"

        prepare extconf
        make    extconf
      end
    end

    private

    def prepare(extconf)
      cmd    = "cd #{path extconf} && ruby extconf.rb"
      result = system cmd

      unless result
        puts cmd
        exit 1
      end
    end

    def make(extconf)
      puts "Making #{gem.name}"
      cmd    = "cd #{path extconf} && make && make install 2>&1"
      result = `#{cmd}`

      if $?.to_i > 0
        puts cmd
        puts result
        exit 1
      end
    end

    def path(file)
      File.expand_path File.dirname(file)
    end
  end
end
