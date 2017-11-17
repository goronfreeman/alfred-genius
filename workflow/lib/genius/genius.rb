require_relative "genius/version"
require_relative "genius/errors"
require_relative "genius/resource"
require_relative "genius/artist"
require_relative "genius/song"
require_relative "genius/web_page"
require_relative "genius/account"
require_relative "genius/annotation"
require_relative "genius/referent"

module Genius
  class << self
    attr_accessor :access_token
    attr_writer   :text_format

    PLAIN_TEXT_FORMAT = "plain".freeze

    def text_format
      @text_format || PLAIN_TEXT_FORMAT
    end
  end
end
