$LOAD_PATH << '.'
require 'base'

require 'open-uri'

module AlfredGenius
  class Search
    include AlfredGenius::Base

    attr_reader :query

    def initialize
      @query = ARGV[0]
    end

    def search
      set_access_token
      output_json(Genius::Song.search(query))
    rescue
      rescue_json
    ensure
      print @@workflow.output
    end

    private

    def set_access_token
      config = YAML.load_file("#{@@dir_path}/settings.yml")
      Genius.access_token = config['access_token']
    end

    def output_json(songs)
      return generic_json if query.length < 4
      songs.each { |song| results_json(song) }
    end

    def results_json(song)
      full_title = song.resource['full_title']
      primary_artist = song.primary_artist
      cache_path = "#{@@home_path}/Library/Caches/com.runningwithcrayons.Alfred-3/extensions_tmp"
      art_path = "#{cache_path}/#{song.id}.png"
      song_art = File.exist?(art_path) ? art_path : download_art(song, cache_path, art_path)

      @@workflow.result
                .uid(song.id)
                .title(song.title)
                .subtitle(primary_artist.name)
                .quicklookurl(song.url)
                .type('default')
                .arg(song.url)
                .valid(true)
                .icon(song_art)
                .mod('cmd', 'View artist on Genius', primary_artist.url)
                .mod('alt', "Search for #{full_title}", "https://www.google.com/search?q=#{full_title}")
                .text('copy', song.url)
    end

    def generic_json
      @@workflow.result
                .title('Be more specific 🤔')
                .subtitle('Enter 3 or more characters to narrow your search')
                .type('default')
                .valid(false)
                .icon('img/not-found.png')
    end

    def rescue_json
      @@workflow.result
                .title('Genius is not set up yet!')
                .subtitle('Press Enter to begin the setup process')
                .type('default')
                .arg('https://genius.com/api-clients/new')
                .valid(true)
                .icon('img/not-found.png')
    end

    def download_art(song, cache_path, art_path)
      file = open(song.resource['song_art_image_thumbnail_url'])
      IO.copy_stream(file, "#{cache_path}/#{song.id}.png")
      art_path
    end
  end
end

AlfredGenius::Search.new.search
