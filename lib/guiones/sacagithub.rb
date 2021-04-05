require 'byebug'
require 'open-uri'
require 'net'


url = 'https://api.github.com/repos/pasosdeJesus/sivel2_sjrcol/issues?state=closed'
uri = URI.parse(url)
h = Net::HTTP.get(uri)
h.use_ssl = true
j=JSON.parse(h)
puts j
byebug

