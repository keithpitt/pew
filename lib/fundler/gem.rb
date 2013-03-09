module Fundler
  class Gem
    def self.bin_path(gem, bin)
      Fundler.find(gem).bin_path bin
    end

    def self.try_activate(*args)
      false
    end

    def self.path
      [ Fundler.gem_path ]
    end

    def self.default_dir
      Fundler.gem_path
    end

    attr_reader :path, :name, :version

    def initialize(path)
      @path           = path
      @name, @version = basename.split("-")
    end

    def installed?
      Dir.exist?(gem_path)
    end

    def install
      installer = Installer.new(self)
      installer.install
    end

    def gem_path
      File.join Fundler.gem_path, basename
    end

    def bin_path(file = nil)
      path = [ gem_path, "bin", file ].compact
      File.join *path
    end

    def require_path
      File.join gem_path, "lib"
    end

    private

    def basename
      @basename ||= File.basename(@path, ".*")
    end
  end
end
