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

    def bindir
      normalize_path meta_data['bindir']
    end

    def require_paths
      meta_data['require_paths'].map { |path| normalize_path path }
    end

    def extensions
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
