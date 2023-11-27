require 'net/http'
require 'uri'


repl = false
if ENV['PATH'].include?('runner')
  repl = true;
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
  uristring="#{req.request_uri}".sub("#{req.header['host'][0]}", hostname).sub("http:","https:")
  p uristring
  newURI = URI.parse(uristring)
  
  #request = newRequest(req.request_method,newURI,{},false)
  #p request.uri
  #request=addHeaders(request,req.header)
  #Net::HTTP.start(hostname, 6969)
  
  response=Net::HTTP.get_response(newURI,flattenHeaders(req.header),443)
  #http.request(request)
  #res.code=response.code
  res.status=response.code
  res['Content-Type'] = response.header['content-type']
  if(response.header['content-encoding'])&&repl
    res['Content-Encoding'] = response.header['content-encoding']
  end
  if(response.header['content-length'])
    res['Content-Length'] = response.header['content-length']
  end
  body=response.body
  if body.include?('\x')
    body=body.force_encoding("ISO-8859-1").encode("UTF-8")
  end
  res.body=body
  #Net::HTTP.finish
end