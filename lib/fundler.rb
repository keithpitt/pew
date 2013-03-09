module Fundler
  require 'fileutils'

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
end

require_relative "fundler/gem"
require_relative "fundler/installer"
require_relative "fundler/runner"
require_relative "fundler/setup"
require_relative "fundler/zip"
