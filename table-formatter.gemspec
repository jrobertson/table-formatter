Gem::Specification.new do |s|
  s.name = 'table-formatter'
  s.version = '0.7.0'
  s.summary = 'table-formatter prints a table in plain text format or ' + 
      'Markdown format from an array'
  s.authors = ['James Robertson']
  s.files = Dir['lib/table-formatter.rb'] 
  s.add_runtime_dependency('c32', '~> 0.2', '>=0.2.0')
  s.add_runtime_dependency('rdiscount', '~> 2.2', '>=2.2.0.1')    
  s.signing_key = '../privatekeys/table-formatter.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@jamesrobertson.eu'
  s.homepage = 'https://github.com/jrobertson/table-formatter'
  s.required_ruby_version = '>= 2.1.2'
end
