require 'fileutils'
require 'tmpdir'
require 'pathname'

def gem(gem, version)
  require gem
end

module Fundler
  def self.gem_path
    path = File.join ENV['HOME'], ".fundler", "gems"
    FileUtils.mkdir_p path unless Dir.exist? path

    path
  end

  def self.append_load_path(path)
    $:.unshift path
  end

  def self.find(gem)
    FUNDLER.find gem
  end

  class Runner
    def initialize
      @gems   = []
      @lookup = {}
    end

    def find(name)
      @lookup[name].first
    end

    def exec(name, args = [])
      @gems.each do |gem|
        bin_path = File.join gem.bin_path, name

        Kernel.exec "#{bin_path} #{args.join " "}" if File.exist? bin_path
      end
    end

    def require(path)
      gem = Gem.new(path)
      gem.install unless gem.installed?

      @gems << gem

      @lookup[gem.name] ||= []
      @lookup[gem.name] << gem

      Fundler.append_load_path gem.require_path
    end
  end
end

module Zip
  def self.extract(file, destination)
    cmd    = "tar -xvf #{File.expand_path(file).inspect} -C #{destination.inspect} 2>&1"
    result = `#{cmd}`

    if $?.to_i > 0
      puts cmd
      puts result
      exit 1
    end
  end
end

class Installer
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
  end
end

class Gem
  class LoadError < StandardError; end

  def self.bin_path(gem, bin)
    Fundler.find(gem).bin_path bin
  end

  def self.try_activate(*args)
    false
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

FUNDLER = Fundler::Runner.new
Dir["vendor/cache/*.gem"].each { |path| FUNDLER.require path }

argv = ARGV.dup
command = argv.shift

if command == "exec"
  script = argv[0]
  args   = argv[1..argv.length]

  FUNDLER.exec script, args
end
