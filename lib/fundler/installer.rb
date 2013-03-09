module Fundler
  class Installer
    require 'fileutils'
    require 'tmpdir'

    attr_accessor :gem

    def initialize(gem)
      @gem = gem
    end

    def gem_path
      gem.gem_path
    end

    def install
      temp_path = Dir.tmpdir
      Zip.extract gem.path, temp_path

      data_path = File.join temp_path, "data.tar.gz"
      FileUtils.mkdir_p gem_path
      Zip.extract data_path, gem_path

      Compiler.new(gem).compile if gem.has_extensions?
    end
  end
end
