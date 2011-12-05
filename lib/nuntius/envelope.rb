module Nuntius
  class Envelope
    include Enumerable
    attr_accessor :data, :key, :signature

    def initialize(attributes)
      self.data      = attributes[:raw_data]      ? encode(attributes[:raw_data])      : attributes[:data]
      self.key       = attributes[:raw_key]       ? encode(attributes[:raw_key])       : attributes[:key]
      self.signature = attributes[:raw_signature] ? encode(attributes[:raw_signature]) : attributes[:signature]
    end

    def to_hash
      {
        :data => data,
        :key => key,
        :signature => signature
      }
    end

    def raw_data
      decode data
    end

    def raw_key
      decode key
    end

    def raw_signature
      decode signature
    end

    def each(&block)
      self.to_hash.each(&block)
    end

    protected
      def encode(string)
        Encodings::URLSafeBase64.encode(string)
      end

      def decode(string)
        Encodings::URLSafeBase64.decode(string)
      end
  end
end
