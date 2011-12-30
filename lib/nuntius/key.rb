module Nuntius
  class Key
    attr_accessor :signature_key
    attr_accessor :encryption_key
    
    def initialize(key_data)
      case key_data
      when Hash
        self.signature_key = OpenSSL::PKey::RSA.new( key_data[:signature] )
        self.encryption_key = OpenSSL::PKey::RSA.new( key_data[:encryption] )
      when Nuntius::Key
        self.signature_key = key_data.signature_key
        self.encryption_key = key_data.encryption_key
      else
        self.signature_key = self.encryption_key = OpenSSL::PKey::RSA.new(key_data)
      end
    end

    def private?
      signature_key.private? && encryption_key.private?
    end

    def ==(key)
      case key
      when Nuntius::Key
        signature_key == key.signature_key &&
          encryption_key == key.encryption_key
      else
        false
      end
    end

    def sign(string)
      digest = OpenSSL::Digest::SHA512.new.digest(string)

      signature_key.private_encrypt(digest)
    end

    def validate(message,signature)
      digest = OpenSSL::Digest::SHA512.new.digest(message)
      digest == signature_key.public_decrypt(signature)
    end

    def encrypt(string)
      encryption_key.public_encrypt(string)
    end

    def decrypt(string)
      encryption_key.private_decrypt(string)
    end
  end
end
