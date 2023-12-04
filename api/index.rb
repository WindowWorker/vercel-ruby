require 'net/http'
require 'uri'
require "zlib"
require_relative 'xhttp'
require_relative 'link-resolver-js'
require_relative 'rubystyle-css'
require_relative 'rubyscript'
require_relative 'highlight-js'

repl = false
if ENV['PATH'].include?('runner')
  repl = true;
end




def flattenHeaders(headers)
  flatHeaders={};
  headers.each do |attr_name, attr_value|
    hostname = "www.ruby-lang.org"
    if !(attr_name.include?("x-"))
      flatHeaders[attr_name]=attr_value[0].sub("#{headers['host'][0]}", hostname)
    end
  end
  return flatHeaders
end

def addHeaders(request,headers)
  flatHeaders={};
  headers.each do |attr_name, attr_value|
    hostname = "www.ruby-lang.org"
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
    hostTargetList = ['www.ruby-lang.org','docs.ruby-lang.org','ruby-doc.com'];
    req_request_uri="#{req.request_uri}"
    
    if req_request_uri.include?('link-resolver.js')
      res['Content-Type']='text/javascript;charset=UTF-8'
      res.body = link_resolver()
      next
    end

    if req_request_uri.include?('rubyscript.js')
      res['Content-Type']='text/javascript;charset=UTF-8'
      res.body = rubyscript()
      next
    end

    if req_request_uri.include?('highlight.js')
      res['Content-Type']='text/javascript;charset=UTF-8'
      res.body = highlight()
      next
    end

    if req_request_uri.include?('rubystyle.css')
      res['Content-Type']='text/css;charset=UTF-8'
      res.body = rubystyle()
      next
    end
    
    hostname = "www.ruby-lang.org"
    if req_request_uri.include?('hostname=')
      hostnamep=req_request_uri.split('hostname=')[1].split('&')[0]
      if hostnamep && (hostnamep != 'undefined')
        hostname = hostnamep
      end
    end
    req.header['proxyhost']=[hostname]
    
    response=fetch(req)
    if response.code.to_i > 299
      originhost = req.header['proxyhost'][0]
      for host in hostTargetList do
        if host == originhost
          next
        end
        req.header['proxyhost']=[host]
        fresponse=fetch(req)
        if response.code.to_i < 400
          response=fresponse
        end
        if response.code.to_i < 300
          break
        end
      end
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
    injects ='<script>globalThis.proxyhost="'+ req.header['proxyhost'][0] +'";</script>' + '<script src="/api/link-resolver.js"></script><script src="/api/rubyscript.js"></script><script src="/api/highlight.js"></script><link rel="stylesheet" type="text/css" href="/api/rubystyle.css">'
    body=body.sub('</head>',injects+'</head>')
    body=body.sub('</HEAD>',injects+'</HEAD>')
    body=body.sub('<head>','<head>'+injects)
    body=body.sub('<HEAD>','<HEAD>'+injects)
    res['Content-Length'] = body.length
    res.body=body

  rescue Exception => error
   body=error.inspect+error.message
    res['Content-Type']='text/html'
   res['Content-Length'] = body.length
   res.body=body
  end
end