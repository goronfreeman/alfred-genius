require 'alfred-3_workflow'
require 'fileutils'
require 'genius'
require 'yaml'

dir_path = FileUtils.mkdir_p("#{ENV['HOME']}/Library/Application Support/Alfred 3/Workflow Data/com.goronfreeman.genius.alfredworkflow")[0]
file_path = "#{dir_path}/settings.yml"
FileUtils.touch(file_path) unless File.exist?(file_path)
config = YAML.load_file(file_path) || {}

config['access_token'] = ARGV[0]
File.open(file_path, 'w') { |f| YAML.dump(config, f) }

workflow = Alfred3::Workflow.new

workflow.result
        .title(ARGV[0])
        .subtitle('Set Genius Access Token')
        .icon('icon.png')
        .arg('https://genius.com/api-clients/new')

print workflow.output
