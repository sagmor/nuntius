def get_key(key_name)
  Nuntius::Key.new File.read( File.expand_path("../../keys/"+key_name, __FILE__) )
end
