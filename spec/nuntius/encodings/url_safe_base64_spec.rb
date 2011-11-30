require 'spec_helper'

describe Nuntius::Encodings::URLSafeBase64 do

  before(:all) do
    @samples = {
      "" => "",
      "Hello World" => "SGVsbG8gV29ybGQ",
      OpenSSL::Digest::SHA512.new("").digest =>
        "z4PhNX7vuL3xVChQ1m2AB9Yg5AULVxXcg_SpIdNs6c5H0NE8XYXysP-DGNKHfuwvY7kxvUdBeoGlODJ6-SfaPg",
      "The quick brown fox jumps over the lazy dog" => 
        "VGhlIHF1aWNrIGJyb3duIGZveCBqdW1wcyBvdmVyIHRoZSBsYXp5IGRvZw"
    }
  end

  before(:each) do
    @encoder = Nuntius::Encodings::URLSafeBase64
  end

  it "should encode messages using RFC4648 compatible Base 64 Encoding with URL and Filename Safe Alphabet" do
    @samples.each do |string,expected|
      @encoder.encode(string).should == expected
    end
  end

  it "should decode valid RFC4648 compatible Base 64 Encoding with URL and Filename Safe Alphabet messages" do 
    @samples.each do |expected,string|
      @encoder.decode(string).should == expected
    end
  end

  it "should raise an exception on wrongly encoded messages" do
    expect { @encoder.decode "wrong encoding" }.to raise_error(Nuntius::Encodings::DecodingError)
  end

end
