
require 'spec_helper'

describe Nuntius::Key do
  it "should be created using another key" do
    @key1 = Nuntius::Key.new( get_key_data('alice.pub') )
    @key2 = Nuntius::Key.new(@key1)

    @key2.should == @key1
  end

  it "should handle different signing/encryption keys" do
    @signature  = get_key_data('bob.pub')
    @encryption = get_key_data('alice.pub')

    @key = Nuntius::Key.new({
      :signature  => @signature,
      :encryption => @encryption
    })
  end

end
