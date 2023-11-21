Handler = Proc.new do |req, res|
  puts 'path:'
  puts req.path
  puts 'req:'
  puts req.request_uri
  puts 'host:'
  puts req.header['host']
	res.status = 200
	res['Content-Type'] = 'text/text; charset=utf-8'
	res.body = "Hello, #{req.request_uri}!"

end