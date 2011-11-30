require 'openssl'

module Nuntius
  class Error < RuntimeError; end
end

require "nuntius/version"
require "nuntius/encodings"
require "nuntius/key"
require "nuntius/envelope"
require "nuntius/messenger"
