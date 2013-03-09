module Fundler
  require 'fileutils'

  def self.gem_path
    path = File.join ENV['HOME'], ".fundler", "gems"
    FileUtils.mkdir_p path unless Dir.exist? path

    # Once we can build c-extensions - use this one.
    path
  end

  def self.root
    File.expand_path File.join(__FILE__, "..")
  end

  def self.find(gem)
    FUNDLER.find gem
  end
end

require_relative "fundler/gem"
require_relative "fundler/installer"
require_relative "fundler/runner"
require_relative "fundler/setup"
require_relative "fundler/zip"
require_relative "fundler/compiler"
