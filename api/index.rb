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

favicon = 'https://archives.bulbagarden.net/media/upload/thumb/1/1e/Menu_HOME_0383.png/40px-Menu_HOME_0383.png'


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
    #puts req.inspect
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

    if req_request_uri.include?('reflect=html')
      res['Content-Type']='text/html;charset=UTF-8'
      res.body = req.inspect
      next
    end

    if req_request_uri.include?('reflect=text')
      res['Content-Type']='text/plain;charset=UTF-8'
      res.body = req.inspect
      next
    end

    if req_request_uri.include?('reflect=debug')
      res['Content-Type']='text/html;charset=UTF-8'
      res.body = ('<pre><code>'+req.inspect+'</code></pre><script src="/api/rubyscript.js"></script><script src="/api/highlight.js"></script>').gsub(',',",\n<br>")
      next
    end

    
    ref = nil
    if req['referer']
      ref="#{req['referer']}".encode("ascii", "utf-8", replace: "/")
    end

    if (req_request_uri.include?('favicon') || req_request_uri.include?('apple-touch-icon')) && ((ref && ref.include?('sapphire'))||(req['workerhost'] && req['workerhost'].include?('sapphire')))
      res.header['location']='https://api.typescripts.org/corsFetch/https://archives.bulbagarden.net/media/upload/thumb/e/ee/Menu_HOME_0382.png/40px-Menu_HOME_0382.png'
      res.status='301'
      next
    end
    
    if (req_request_uri.include?('favicon') || req_request_uri.include?('apple-touch-icon')) && ((ref && ref.include?('emerald'))||(req['workerhost'] && req['workerhost'].include?('emerald')))
      res.header['location']='https://api.typescripts.org/corsFetch/https://archives.bulbagarden.net/media/upload/thumb/6/6e/Menu_HOME_0384.png/40px-Menu_HOME_0384.png'
      res.status='301'
      next
    end

    if (req_request_uri.include?('favicon') || req_request_uri.include?('apple-touch-icon')) && ((ref && ref.include?('rua.'))||(req['workerhost'] && req['workerhost'].include?('rua.')))
      res.header['location']='https://api.typescripts.org/corsFetch/https://archives.bulbagarden.net/media/upload/1/1b/112_II_OD.png'
      res.status='301'
      next
    end

    
    
    if req_request_uri.include?('favicon') || req_request_uri.include?('apple-touch-icon')
      res.header['location']='https://api.typescripts.org/corsFetch/https://archives.bulbagarden.net/media/upload/thumb/1/1e/Menu_HOME_0383.png/40px-Menu_HOME_0383.png'
      res.status='301'
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
    
    if (!(response.header['content-type'].include?('text')))
      begin
        text=body
        text.encode('UTF-8')
      rescue Exception => error
        body = body.unpack('C*').inspect
        res['encoding-shim']='UTF-8'
      end
    end

    workerhost = "";
    if(req['workerhost'])
      workerhost=' workerhost='+req['workerhost']+' '
    end
    
    injects ='<script>globalThis.proxyhost="'+ req.header['proxyhost'][0] +'";</script>' + <<-TEXT
    <script src="/api/link-resolver.js"></script>
    <script src="/api/rubyscript.js"></script>
    <script src="/api/highlight.js"></script>
    <link rel="stylesheet" type="text/css" href="/api/rubystyle.css"> 
    TEXT
    injects=injects+'<debug style="display:none;">'+req.inspect.gsub(',',",\n")+'</debug>'


body=body.sub('<html','<html'+workerhost)

    body=body.sub('<HTML','<HTML'+workerhost)
    body=body.sub('</head>',injects+'</head>')
    body=body.sub('</HEAD>',injects+'</HEAD>')
    body=body.sub('<head>','<head>'+injects)
    body=body.sub('<HEAD>','<HEAD>'+injects)
    response.header.each do |attr_name, attr_value|
      if (attr_name.downcase == 'content-encoding') && (attr_value.downcase.include?('gzip'))
        next
      end
      res[attr_name] = attr_value
    end
    res['Content-Length'] = body.length
    res.body=body

  rescue Exception => error
   body=('<pre><code>'+error.inspect+error.message+"\n<br>"+req.inspect+'</code></pre><script src="/api/rubyscript.js"></script><script src="/api/highlight.js"></script>').gsub(',',",\n<br>")
   res['Content-Type']='text/html;charset=UTF-8'
   res['Content-Length'] = body.length
   res.body=body
  end
end