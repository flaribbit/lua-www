local http = require "socket.http"

local www = {
    url = "http://www",
    __index = function(self, s)
        self.url = self.url.."."..s
        return self
    end,
    __div = function(self, s)
        self.url = self.url.."/"..s
        return self
    end,
    get = function(self, fun)
        local b, s, h = http.request(self.url)
        fun({body=b, status=s, header=h})
        self.url = "http://www"
    end
}
setmetatable(www, www)
setmetatable(_G, {__index = function(self, k) return k end})

www.baidu.com:get(function (res)
    print(res.status, #res.body)
end)

;(www.test.com/test):get(function (res)
    print(res.status, #res.body)
end)
