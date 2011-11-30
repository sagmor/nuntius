module Nuntius
  module Encodings

    # Encode/Decode messages using RFC4648 Base 64 Encoding
    # with URL and Filename Safe Alphabet {http://tools.ietf.org/html/rfc4648#section-5}
    module URLSafeBase64
      BASE_CHARACTERS = "+/"
      REPLACEMENT_CHARACTERS = "-_"
      PADDING_CHARACTER = "="

      def self.encode(bin)
        [bin].pack("m0").tr(BASE_CHARACTERS,REPLACEMENT_CHARACTERS).gsub(PADDING_CHARACTER,'')
      end

      def self.decode(bin)
        padding = (4 - (bin.length % 4)) % 4
        ( bin.tr(REPLACEMENT_CHARACTERS, BASE_CHARACTERS) + ( PADDING_CHARACTER * padding ) ).unpack("m0").first
      rescue ArgumentError
        raise Nuntius::Encodings::DecodingError.new 'Invalid Base64'
      end

    end

  end
end

