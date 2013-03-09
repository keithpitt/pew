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
      ext_paths = [
        [ "extconf.rb" ],
        [ "#{gem.name}", "extconf.rb" ],
        [ "ffi_c", "extconf.rb" ],
        [ "unicorn_http", "extconf.rb" ]
      ].map { |p| File.join gem.ext_path, *p }

      extconf = ext_paths.find { |path| File.exist?(path) }

      if extconf
        prepare extconf
        make    extconf
      else
        puts "ERROROROR!!11: Could not find extconf for #{gem.name} #{gem.require_path}"
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
