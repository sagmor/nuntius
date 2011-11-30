module Nuntius
  class Messenger
    attr_accessor :key

    def initialize(attributes)
      self.key = attributes[:key]
    end

    def wrap(options)
      cipher = OpenSSL::Cipher.new('AES-256-CBC').encrypt

      key = options[:to].encrypt( cipher.random_key )
      data = cipher.update( options[:message] ) + cipher.final
      signature = @key.sign(data)

      Envelope.new({
        :raw_data => data,
        :raw_key => key,
        :raw_signature => signature 
      })
    end

    def unwrap(options)
      data = options[:envelope].raw_data
      signature = options[:envelope].raw_signature

      options[:from].validate(data, signature)

      key = @key.decrypt options[:envelope].raw_key

      cipher = OpenSSL::Cipher.new('AES-256-CBC').decrypt
      cipher.key = key

      cipher.update(data) + cipher.final
    end
  end
end
