def get_key_data(key_name)
  File.read( File.expand_path("../../keys/"+key_name, __FILE__) )
end
def get_key(key_name)
  Nuntius::Key.new( get_key_data(key_name) )
end
