module Fundler
  class Gem
    require 'json'

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

    def meta_data
      @meta_data ||= JSON.load File.read(meta_data_path)
    end

    def meta_data_path
      File.join(gem_path, "fundler.json")
    end

    def bin_path(file = nil)
      path = [ gem_path, "bin", file ].compact
      File.join *path
    end

    def load_paths
      require_paths + ext_paths
    end

    def require_paths
      meta_data['require_paths'].map { |path| normalize_path path }
    end

    def ext_paths
      meta_data['extensions'].map { |path| normalize_path path }
    end

    private

    def normalize_path(path)
      File.join(gem_path, path)
    end

    def basename
      @basename ||= File.basename(@path, ".*")
    end
  end
end
