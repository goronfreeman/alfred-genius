require_relative 'base'

require 'open-uri'

module AlfredGenius
  class Search
    include AlfredGenius::Base

    attr_reader :query

    def initialize
      @query = ARGV.join(' ')
    end

    def search
      set_access_token
      output_json
    rescue
      rescue_json
    ensure
      print Base.workflow.output
    end

    private

    def set_access_token
      config = YAML.load_file("#{Base.dir_path}/settings.yml")
      Genius.access_token = config['access_token']
    end

    def output_json
      return generic_json if query.length < 4
      songs = Genius::Song.search(query)
      return no_match_json if songs.empty?
      songs.each { |song| results_json(song) }
    end

    def results_json(song)
      full_title     = song.resource['full_title']
      primary_artist = song.primary_artist
      song_art       = find_art(song)

      Base.workflow.result
          .uid(song.id)
          .title(song.title)
          .subtitle(primary_artist.name)
          .quicklookurl(song.url)
          .arg(song.url)
          .icon(song_art)
          .mod('cmd', 'View artist on Genius', primary_artist.url)
          .mod('alt', "Search for #{full_title}", "https://www.google.com/search?q=#{full_title}")
          .text('copy', song.url)
          .autocomplete(song.title)
    end

    def no_match_json
      Base.workflow.result
          .title('No matches found!')
          .subtitle('Try a different search term')
          .valid(false)
          .icon('img/not-found.png')
    end

    def generic_json
      Base.workflow.result
          .title('Be more specific 🤔')
          .subtitle('Enter 3 or more characters to narrow your search')
          .valid(false)
          .icon('img/not-found.png')
    end

    def rescue_json
      Base.workflow.result
          .title('Genius is not set up yet!')
          .subtitle('Press Enter to begin the setup process')
          .arg('https://genius.com/api-clients/new')
          .icon('img/not-found.png')
    end

    def find_art(song)
      cache_path = "#{Base.home_path}/Library/Caches/com.runningwithcrayons.Alfred-3/extensions_tmp"
      art_path   = "#{cache_path}/#{song.id}.png"
      File.exist?(art_path) ? art_path : download_art(song, cache_path, art_path)
    end

    def download_art(song, cache_path, art_path)
      file = open(song.resource['song_art_image_thumbnail_url'])
      IO.copy_stream(file, "#{cache_path}/#{song.id}.png")
      art_path
    end
  end
end

AlfredGenius::Search.new.search
