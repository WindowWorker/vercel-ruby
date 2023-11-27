

def newRequest (method,uri,headers,body)
  req = nil
  case method.upcase
  when 'GET'
    req = Net::HTTP::Get.new(uri,headers)
  when 'HEAD'
    req = Net::HTTP::Head.new(uri,headers)
  when 'POST'
    req = Net::HTTP::Post.new(uri,headers)
  when 'PUT'
    req = Net::HTTP::Put.new(uri,headers)
  when 'DELETE'
    req = Net::HTTP::Delete.new(uri,headers)
  when 'OPTIONS'
    req = Net::HTTP::Options.new(uri,headers)
  when 'TRACE'
    req = Net::HTTP::Trace.new(uri,headers)
  when 'PATCH'
    req = Net::HTTP::Patch.new(uri,headers)
  when 'PROPFIND'
    req = Net::HTTP::Propfind.new(uri,headers)
  when 'PROPPATCH'
    req = Net::HTTP::Proppatch.new(uri,headers)
  when 'MKCOL'
    req = Net::HTTP::Mkcol.new(uri,headers)
  when 'COPY'
    req = Net::HTTP::Copy.new(uri,headers)
  when 'MOVE'
    req = Net::HTTP::Move.new(uri,headers)
  when 'LOCK'
    req = Net::HTTP::Lock.new(uri,headers)
  when 'UNLOCK'
    req = Net::HTTP::Unlock.new(uri,headers)
  else
    req = Net::HTTP::Get.new(uri,headers)
  end

  if body
    req.body = body
  end
  puts req
  return req
end
