#!/usr/bin/env ruby
# encoding: utf-8

require 'rubygems' unless defined? Gem # rubygems is only needed in 1.8
require_relative 'bundle/bundler/setup'
require 'alfred'
require 'alfred-3_workflow'
require 'genius'
require 'open-uri'
require 'yaml'

begin
  workflow = Alfred3::Workflow.new

  dir_path = FileUtils.mkdir_p("#{ENV['HOME']}/Library/Application Support/Alfred 3/Workflow Data/com.goronfreeman.genius.alfredworkflow")[0]
  config = YAML.load_file("#{dir_path}/settings.yml")

  Genius.access_token = config['access_token']
  songs = Genius::Song.search(ARGV[0])

  def download_art(song, cache_path, art_path)
    file = open(song.resource['song_art_image_thumbnail_url'])
    IO.copy_stream(file, "#{cache_path}/#{song.id}.png")
    art_path
  end

  songs.each do |song|
    full_title = song.resource['full_title']
    primary_artist = song.primary_artist.name
    home_path = ENV['HOME']
    cache_path = "#{home_path}/Library/Caches/com.runningwithcrayons.Alfred-3/extensions_tmp"
    art_path = "#{cache_path}/#{song.id}.png"
    song_art = File.exist?(art_path) ? art_path : download_art(song, cache_path, art_path)

    workflow.result
            .uid(song.id)
            .title(song.title)
            .subtitle(primary_artist)
            .quicklookurl(song.url)
            .type('default')
            .arg(song.url)
            .valid(true)
            .icon(song_art)
            .mod('cmd', "Search for #{full_title}", 'search')
            .text('copy', song.url)
  end

  print workflow.output
rescue => e
  workflow.result
          .title('Genius is not set up yet!')
          .subtitle('Press Enter to begin the setup process.')
          .icon('icon.png')
          .arg('https://genius.com/api-clients/new')

  print workflow.output
end
