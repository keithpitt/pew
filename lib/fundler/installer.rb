module Fundler
  class Installer
    require 'fileutils'
    require 'tmpdir'
    require 'yaml'
    require 'json'

    attr_accessor :gem

    def initialize(gem)
      @gem = gem
    end

    def gem_path
      gem.gem_path
    end

    def install
      temp_path = Dir.tmpdir
      extract gem.path, temp_path

      data_path = File.join temp_path, "data.tar.gz"
      FileUtils.mkdir_p gem_path
      extract data_path, gem_path

      meta_data_path = File.join(temp_path, "metadata.gz")
      meta_data      = read_meta_data(meta_data_path)

      File.open gem.meta_data_path, 'w' do |file|
        file.write JSON.generate(meta_data)
      end

      Compiler.new(gem).compile unless gem.extensions.empty?
    end

    private

    def read_meta_data(file)
      yaml =  `gunzip -c #{file}`

      # A shit implementation of making the yaml safe to load
      # TODO: Make better.
      yaml.gsub! /!ruby\/object.+$/, ''

      YAML.load yaml
    end

    def extract(file, destination)
      cmd    = "tar -xvf #{File.expand_path(file).inspect} -C #{destination.inspect} 2>&1"
      result = `#{cmd}`

      if $?.to_i > 0
        puts cmd
        puts result
        exit 1
      end
    end
  end
end
