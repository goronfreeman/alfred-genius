$LOAD_PATH << '.'
require 'base'

module AlfredGenius
  class Setup
    include AlfredGenius::Base

    attr_reader :token

    def initialize
      @token = ARGV[0]
    end

    def setup
      save_token
      output_json
    end

    private

    def save_token
      file_path = "#{@@dir_path}/settings.yml"
      FileUtils.touch(file_path) unless File.exist?(file_path)
      config = YAML.load_file(file_path) || {}

      config['access_token'] = token
      File.open(file_path, 'w') { |f| YAML.dump(config, f) }
    end

    def output_json
      @@workflow.result
                .title(token)
                .subtitle('Set Genius Access Token')
                .type('default')
                .valid(true)
                .icon('img/icon.png')
                .arg('https://genius.com/api-clients/new')

      print @@workflow.output
    end
  end
end

AlfredGenius::Setup.new.setup
