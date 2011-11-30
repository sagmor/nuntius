module Nuntius
  module Encodings
    # Encode/Decode messages using RFC4648 Base 64 Encoding
    # with URL and Filename Safe Alphabet {http://tools.ietf.org/html/rfc4648#section-5}
    module URLSafeBase64
      def self.encode(bin)
        [bin].pack("m0").tr("-_", "+/").gsub(/(=)*$/,'')
      end

      def self.decode(bin)
        padding = (4 - (bin.length % 4)) % 4
        ( bin.tr("+/","-_") + ( "=" * padding ) ).unpack("m0").first
      rescue ArgumentError
        raise Nuntius::Encodings::DecodingError.new 'Invalid Base64'
      end
    end
  end
end

