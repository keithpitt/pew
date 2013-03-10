module Pew
  require 'fileutils'

  def self.gem_path
    path = File.join ENV['HOME'], ".pew", "gems"
    FileUtils.mkdir_p path unless Dir.exist? path

    # Once we can build c-extensions - use this one.
    path
  end

  def self.command_without_rubygems(command, args = [])
    %{RUBYOPT="--disable=gem -I#{Pew.root} -rpew/setup" ruby #{command} #{args.join " "}}
  end

  def self.root
    File.expand_path File.join(__FILE__, "..")
  end

  def self.find(gem)
    PEW.find gem
  end
end

require_relative "pew/gem"
require_relative "pew/bundler"
require_relative "pew/installer"
require_relative "pew/runner"
require_relative "pew/compiler"

require_relative "pew/environment/base"
require_relative "pew/environment/all"
require_relative "pew/environment/locked"

require_relative "pew/kernel/require"
