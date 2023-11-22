require 'net/http'
require 'uri'







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



def flattenHeaders(headers)
  flatHeaders={};
  headers.each do |attr_name, attr_value|
    hostname = "docs.ruby-lang.org"
    if !(attr_name.include?("x-"))
      flatHeaders[attr_name]=attr_value[0].sub("#{headers['host'][0]}", hostname)
    end
  end
  return flatHeaders
end

def addHeaders(request,headers)
  flatHeaders={};
  headers.each do |attr_name, attr_value|
    hostname = "docs.ruby-lang.org"
    if (!(attr_name.include?("x-")))&&(!(attr_name.include?("referer")))&&(!(attr_name.include?("cookie")))&&(!(attr_name.include?("host")))&&(!(attr_name.include?("sec-")))&&(!(attr_name.include?("accept-")))&&(!(attr_name.include?("upgrade-")))&&(!(attr_name.include?("user-agent")))
      a2 = attr_value[0].sub("#{headers['host'][0]}", hostname)
      #p attr_name+":"+a2
      request[attr_name] = a2
    end
  end
  return request
end

def printHeaders(headers)
  flatHeaders={};
  headers.each do |attr_name, attr_value|
   puts attr_name +':'+ attr_value
  end
  return flatHeaders
end

Handler = Proc.new do |req, res|
  hostname = "docs.ruby-lang.org"#"docs.ruby-lang.org"

  puts req.header['host']
  res.status = 200
  uristring="#{req.request_uri}".sub("#{req.header['host'][0]}", hostname).sub("http:","https:")
  p uristring
  newURI = URI.parse(uristring)
  
  #request = newRequest(req.request_method,newURI,{},false)
  #p request.uri
  #request=addHeaders(request,req.header)
  response=Net::HTTP.get_response(newURI)#http.request(request)
  res['Content-Type'] = response.header['content-type']
  res.body=response.body
  res.status=response.code
end