Gem::Specification.new do |s|
  s.name = 'table-formatter'
  s.version = '0.1.13'
  s.summary = 'table-formatter prints a table in plain text format from an array'
    s.authors = ['James Robertson']
  s.files = Dir['lib/**/*.rb'] 
  s.signing_key = '../privatekeys/table-formatter.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@r0bertson.co.uk'
  s.homepage = 'https://github.com/jrobertson/table-formatter'
end
