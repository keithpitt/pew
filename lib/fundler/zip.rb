module Fundler
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
end
