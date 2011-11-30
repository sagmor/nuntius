require 'spec_helper'

describe Nuntius::Messenger do
  before(:each) do
    @messenger = Nuntius::Messenger.new key: get_key('bob.pem')
    @alice = get_key('alice.pub')
  end

  it "should encrypt and sign messages" do
    @envelope = @messenger.wrap message: "Hello Allice", to: @alice

    @envelope.key.should_not be_nil
    @envelope.signature.should_not be_nil
    @envelope.data.should_not be_nil
  end

  it "should decrypt valid messages" do
    @envelope = Nuntius::Envelope.new({
      data: "EiOgHgmZQ6Lsg1QKobu5AA",
      key: "PjLZjiwU9kZlOsDYhiiwf_P7Vkvd3l-rtk5MMU7EoYyObTj_H52ujyHlwuzDjgI_KyGKU95U5F8zDrjegsVTkhN6b1t73BQ8ImEOXwsicb1hwsaKbDT3PJLR5c0Zk-x_RbaAEE-7Sd3Vodg0qJul1v0b6us-uJZNX5sqjsfvvQn_LCVtgtvWKru_YzLwxVsZD4tNCu_misl6D-BOewkOHovwGiJPqirvSTR7jPWNPbQHgSL0xvdqFL6kEAwzJ_p5Oj1KH68dNeRhBKU8HwSfc8ZEMCTlcwVWMlc2NcxNhiSbjSxCHjawK5zegviqlhYhzw9J_HDMIMMe7K4gk3O_iA",
      signature: "FF5BhVNFzcoQQbV9_MOsgBHpaLLWKIe0AxmXwx7dOU5QlRmlwzdJhKdQOCUHmbuJIqTfR444kEznQTyAKF66Pmk7UgFniKcmPLPHSfYf5e5BzUkYb2oXI1yqk3qOl9NTb82oVinBOQweufNyo1rmH6b5GrB811xQmzTco7Frogzt5aWGC7BY9x2FWoes633vOMvC4z3kprL4XQVVH2cqIqIvbBXtFteIagy_90HsLA4mfjf1ku5Sjzv5789L2lUUc2oCic5BqUAx0AQ2y9I_q0J8uu4MXCX3vD53Iq5IsrCr2-h6f1nWoHbYWf6aDU4pYGOqStQJRYkurnlh7docFA"
    })

    @messenger.unwrap(envelope: @envelope, from: @alice).should == "Hello Bob!"
  end
end
