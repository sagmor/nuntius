module Nuntius
  module Encodings
    class DecodingError < Error; end
  end
end

%w{url_safe_base64}.each do |encoding|
  require "nuntius/encodings/#{encoding}"
end
