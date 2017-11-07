$LOAD_PATH << 'lib/alfred-workflow-ruby'
require 'alfred-3_workflow'

$LOAD_PATH << 'lib/genius'
require 'genius'

require 'fileutils'
require 'yaml'

module AlfredGenius
  module Base
    @@home_path = ENV['HOME']
    @@dir_path = FileUtils.mkdir_p("#{@@home_path}/Library/Application Support/Alfred 3/Workflow Data/com.goronfreeman.genius.alfredworkflow")[0]
    @@workflow = Alfred3::Workflow.new
  end
end
