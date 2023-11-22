require_relative 'api/index.rb'
require 'webrick'

server = WEBrick::HTTPServer.new :Port => 8000
#trap 'INT' do server.shutdown end

server.mount_proc '/' do |req, res|
  Handler[req,res]
end

server.start