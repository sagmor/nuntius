# Nuntius:

### A messenger, reporter, courier, bearer of news or tidings

Nuntius is a simple scheme to send and receive messages in a cryptographicaly secure and compatible way.

## Usage

### Encript a Message

```ruby
  require 'nuntius'

  sender = Nuntius::Key.new( File.read('private_key_path') )
  messenger = Nuntius::Mesenger.new({
    :key => sender
  })

  receiver = Nuntius::Key.new( File.read('public_key_path') )

  envelope = messenger.wrap({
    :message => "Message Content",
    :to => receiver
  })

  envelope.data
    # => The encripted message
  envelope.key
    # => The encripted message key
  envelope.signature
    # => The encripted message signature
```

### Decript a message

```ruby
  require 'nuntius'

  receiver = Nuntius::Key.new( File.read('private_key_path') )
  messenger = Nuntius::Mesenger.new({
    :key => receiver
  })

  sender = Nuntius::Key.new( File.read('public_key_path') )

  envelope = Nuntius::Envelope.new({
    :data => 'The encripted message'
    :key => 'The encripted message key'
    :signature => 'The encripted message signature'
  })

  message = messenger.unwrap({
    :envelope => envelope,
    :from => sender
  })

  message
    # => The verified and decripted raw message
```

## Encription Scheme

Under the hood Nuntius is just a wrapper around OpenSSL and by default uses [RSA](http://en.wikipedia.org/wiki/RSA_(algorithm)), [AES](http://en.wikipedia.org/wiki/Advanced_Encryption_Standard) in [CBC mode](http://en.wikipedia.org/wiki/Block_cipher_modes_of_operation#Cipher-block_chaining_.28CBC.29) and [SHA512](http://en.wikipedia.org/wiki/SHA512) to encript/decript and sign/verify the messages and [URL Safe Base64](http://en.wikipedia.org/wiki/Base64#RFC_4648) to encode/decode the results.

The whole scheme can be sumarized in 4 steps:

 * The message is encripted using AES-256-CBC with a randomly generated key.
 * The key is then encrypted using the receiver's public RSA key.
 * The encripted message's digest is calculated using SHA512 and then signed using the sender's private RSA key.
 * Finally the encripted message, the encripted key and the signed digest are encoded using the RFC4648 URL Safe Base 64 encoding

In other terms, encrypting a message with nuntius is the same as doing

```ruby
  require 'openssl'

  sender = OpenSSL::PKey::RSA.new( File.read('sender_private_key') )
  receiver = OpenSSL::PKey::RSA.new( File.read('receiver_public_key') )

  cipher = OpenSSL::Cipher.new("AES-256-CBC").encrypt
  
  key = receiver.public_encrypt( cipher.random_key )

  data = cipher.update("message") + cipher.final

  signature = receiver.private_encrypt( OpenSSL::Digest::SHA512.new(data).digest )

  result = {
    :data => [data].pack("m0").tr("+/","-_").gsub("=","")
    :key => [key].pack("m0").tr("+/","-_").gsub("=","")
    :signature => [signature].pack("m0").tr("+/","-_").gsub("=","")
  }
```
