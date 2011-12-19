
require 'spec_helper'

describe Nuntius::Key do
  it "should be created using another key" do
    @key1 = get_key('alice.pub')
    @key2 = Nuntius::Key.new(@key1)

    @key2.to_str.should == @key1.to_str
  end

end
