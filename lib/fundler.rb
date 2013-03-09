module Fundler
  require 'fileutils'

  def self.gem_path
    path = File.join ENV['HOME'], ".fundler", "gems"
    FileUtils.mkdir_p path unless Dir.exist? path

    # Once we can build c-extensions - use this one.
    path
  end

  def self.command_without_rubygems(command, args = [])
    %{RUBYOPT="--disable=gem -I#{Fundler.root} -rfundler/setup" #{command} #{args.join " "}}
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
require_relative "fundler/compiler"
