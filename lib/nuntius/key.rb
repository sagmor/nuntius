module Nuntius
  class Key
    def initialize(key_data)
      @key = OpenSSL::PKey::RSA.new(key_data)
    end

    def private?
      @key.private?
    end

    def to_str
      @key.to_pem
    end

    def hash
      @key.hash
    end

    def ==(key)
      case key
      when Nuntius::Key
        key.hash == self.hash
      else
        false
      end
    end

    def sign(string)
      digest = OpenSSL::Digest::SHA512.new.digest(string)

      @key.private_encrypt(digest)
    end

    def validate(message,signature)
      digest = OpenSSL::Digest::SHA512.new.digest(message)
      digest == @key.public_decrypt(signature)
    end

    def encrypt(string)
      @key.public_encrypt(string)
    end

    def decrypt(string)
      @key.private_decrypt(string)
    end
  end
end
