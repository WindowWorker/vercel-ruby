require 'net/http'
require 'uri'
require "zlib"


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
  begin
    Encoding.default_external=Encoding::UTF_8
    Encoding.default_internal=Encoding::UTF_8
    hostname = "docs.ruby-lang.org"
    puts req.header['host']
    uristring="#{req.request_uri}".sub("#{req.header['host'][0]}", hostname).sub("http:","https:")
    
    puts uristring
    if (uristring.split('.').length == 3) && (uristring[uristring.length-1]!="/")
      uristring=uristring+'/'
    end
    newURI = URI.parse(uristring)
    response = nil
    if req.request_method[0]=="P"
      response=Net::HTTP.post(newURI, req.body(),flattenHeaders(req.header))
    else
      response=Net::HTTP.get_response(newURI,flattenHeaders(req.header),443)
    end
    res.status=response.code
    res['Content-Type'] = response.header['content-type']

    if(response.header['content-length'])
      res['Content-Length'] = response.header['content-length']
    end
    body=response.body
    if(response.header['content-encoding'])&&(response.header['content-encoding']=='gzip')
      body = Zlib.gunzip(body)
    end
    puts "main"

    res['Content-Length'] = body.length
    res.body=body

  rescue Exception => error
   body=error.inspect+error.message
    res['Content-Type']='text/html'
   res['Content-Length'] = body.length
   res.body=body
  end
end