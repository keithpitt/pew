module Pew
  class Gem
    require 'json'

    def self.bin_path(gem, bin)
      Pew.find(gem).bin_path bin
    end

    def self.try_activate(*args)
      false
    end

    def self.path
      [ Pew.gem_path ]
    end

    def self.default_dir
      Pew.gem_path
    end

    attr_reader :path, :name, :version

    def initialize(path)
      @path = path

      # Extract name/version from my-gem-name-1.3.5
      match    = basename.match(/\A(.+)-(.+)\z/)
      @name    = match[1]
      @version = match[2]
    end

    def installed?
      Dir.exist?(gem_path)
    end

    def install
      installer = Installer.new(self)
      installer.install
    end

    def gem_path
      File.join Pew.gem_path, basename
    end

    def meta_data
      @meta_data ||= JSON.load File.read(meta_data_path)
    end

    def meta_data_path
      File.join(gem_path, "pew.json")
    end

    def files
      meta_data['files']
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
