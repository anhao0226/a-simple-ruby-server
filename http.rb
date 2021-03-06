require 'socket'
require './http_method.rb'

def say_hello(context)
    name = context.values("name")
    content = "HTTP/1.1 200/OK\r\nContent-type: text/html\r\n\r\n<html><body><h1> #{name} #{Time.now}</h1></body></html>\r\n"
    context.write(content)
end

def not_found(client)
    client.print "HTTP/1.1 200/OK\r\nContent-type: text/html\r\n\r\n"
    client.print "<html><body><h1>Not Found</h1></body></html>\r\n"
    client.close;
end




# 上下文
class Context

    def initialize(client, params, method = "GET")
        @client = client
        @params = params
        @method = method
    end

    # GET
    def values(key)
        val = @params[key]
        val
    end

    # POST
    def post_form(key)

    end

    def json(data)
        
    end

    def method
        @method    
    end

    def write(str)
        @client.print str
        close
    end

    def close
        @client.close
    end
end


class Router

    def initialize(baseUrl = "")
        @base_url = "";
        @routes = {}
    end

     # GET
     def _get(path, handle)
        @routes[path] = handle
    end

    # POST
    def _post(path, handle)
    
    end

    # DELETE
    def _delete(path, handle)
        
    end

    #
    
end


class Response
    def initialize()

    end
end


class Request
    def initialize
        
    end
end

class SocketServer

    
    def initialize(port = "3000", host = "localhost")
        @port = port
        @host = host
        @routes = {}
    end


    # GET
    def _get(path, handle)
        @routes[path] = handle
    end

    # POST
    def _post(path, handle)
    
    end

    # DELETE
    def _delete(path, handle)
        
    end

    
    # handle_func(Context context)
    def _use(handle_func)

    end

    # 
    def extract_data(str)
        data = {}
        str.split("&").each do |value|
            key, value =  value.split("=")
            data[key] = value
        end
        data
    end

    # 处理请求
    def handle_request(client)
         # 请求方法 路径 协议
        _method, _path, _protocol = client.gets.split
         # 处理其他参数(请求头)
        headers = {}
        while _line = client.gets.split(' ', 2)
            break if _line[0] == ""
            headers[_line[0].chop] = _line[1].strip
        end

        data = {}
        base_url = ""
        method = HttpMethod::GET
        # example http://localhost:3000?name=zhang&age=10
        if _method.upcase == HttpMethod::GET
            #  ?name=zhang&age=10 提取url参数
            if _path.include?('?')
                _split_index =  _path.index('?');
                data = extract_data(_path[(_split_index + 1).._path.length])
                base_url = _path[0..(_split_index-1)]
            elsif
                base_url = _path
            end
        elsif _method.upcase == HttpMethod::POST
            method = HttpMethod::POST
        elsif _method.upcase == HttpMethod::DELETE
            method = HttpMethod::DELETE
        elsif _method.upcase == HttpMethod::PUT
            method = HttpMethod::PUT
        end


        if @routes.has_key?(base_url)
            fn = @routes[base_url]
            context = Context.new(client, data, method)
            fn.call(context)
        elsif
            not_found(client)
        end
    end
    
    def start_server
        begin
            @server = TCPServer.new(@host, @port) #Server bound to port 3000
            puts "TCP on #{@host}:#{@port}"
            loop do
                # Thread
                Thread.start(@server.accept) do |client|
                   handle_request(client)
                end

            end 
        rescue => exception
            @server.close
            puts exception.message
        end
    end
end


server = SocketServer.new

# 路由注册
server._get("/abc", method(:say_hello))

server.start_server();

