require_relative 'lib/alfred-workflow-ruby/alfred-3_workflow'
require_relative 'lib/httparty/httparty'
require_relative 'lib/genius/genius'

require 'fileutils'
require 'yaml'

module AlfredGenius
  module Base
    class << self
      attr_reader :workflow, :home_path, :dir_path
    end

    @workflow  = Alfred3::Workflow.new
    @home_path = ENV['HOME']
    @dir_path  = FileUtils.mkdir_p("#{@home_path}/Library/Application Support/Alfred 3/Workflow Data/com.goronfreeman.genius.alfredworkflow").first
  end
end
