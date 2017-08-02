# 如何防止scrapy爬虫被禁止

>根据scrapy官方文档：http://doc.scrapy.org/en/master/topics/practices.html#avoiding-getting-banned里面的描述，
>要防止scrapy被ban，主要有以下几个策略。

## 1.动态设置user agent
## 2.禁用cookies
## 3.设置延迟下载
## 4.使用IP地址池（Tor project、VPN和代理IP）
## 5.使用Crawlera


# 1、创建middlewares.py
scrapy代理IP、user agent的切换都是通过DOWNLOADER_MIDDLEWARES进行控制，下面我们创建middlewares.py文件。
```
import random  
import base64  
from settings import PROXIES  
  
class RandomUserAgent(object):  
    """Randomly rotate user agents based on a list of predefined ones"""  
  
    def __init__(self, agents):  
        self.agents = agents  
  
    @classmethod  
    def from_crawler(cls, crawler):  
        return cls(crawler.settings.getlist('USER_AGENTS'))  
  
    def process_request(self, request, spider):  
        #print "**************************" + random.choice(self.agents)  
        request.headers.setdefault('User-Agent', random.choice(self.agents))  
  
class ProxyMiddleware(object):  
    def process_request(self, request, spider):  
        proxy = random.choice(PROXIES)  
        if proxy['user_pass'] is not None:  
            request.meta['proxy'] = "http://%s" % proxy['ip_port']  
            encoded_user_pass = base64.encodestring(proxy['user_pass'])  
            request.headers['Proxy-Authorization'] = 'Basic ' + encoded_user_pass  
            print "**************ProxyMiddleware have pass************" + proxy['ip_port']  
        else:  
            print "**************ProxyMiddleware no pass************" + proxy['ip_port']  
            request.meta['proxy'] = "http://%s" % proxy['ip_port']</span>  

类RandomUserAgent主要用来动态获取user agent，user agent列表USER_AGENTS在settings.py中进行配置。

类ProxyMiddleware用来切换代理，proxy列表PROXIES也是在settings.py中进行配置。
```

# 2、修改settings.py配置USER_AGENTS和PROXIES

## a)：添加USER_AGENTS
```
USER_AGENTS = [  
    "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; AcooBrowser; .NET CLR 1.1.4322; .NET CLR 2.0.50727)",  
    "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0; Acoo Browser; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.0.04506)",  
    "Mozilla/4.0 (compatible; MSIE 7.0; AOL 9.5; AOLBuild 4337.35; Windows NT 5.1; .NET CLR 1.1.4322; .NET CLR 2.0.50727)",  
    "Mozilla/5.0 (Windows; U; MSIE 9.0; Windows NT 9.0; en-US)",  
    "Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Win64; x64; Trident/5.0; .NET CLR 3.5.30729; .NET CLR 3.0.30729; .NET CLR 2.0.50727; Media Center PC 6.0)",  
    "Mozilla/5.0 (compatible; MSIE 8.0; Windows NT 6.0; Trident/4.0; WOW64; Trident/4.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; .NET CLR 1.0.3705; .NET CLR 1.1.4322)",  
    "Mozilla/4.0 (compatible; MSIE 7.0b; Windows NT 5.2; .NET CLR 1.1.4322; .NET CLR 2.0.50727; InfoPath.2; .NET CLR 3.0.04506.30)",  
    "Mozilla/5.0 (Windows; U; Windows NT 5.1; zh-CN) AppleWebKit/523.15 (KHTML, like Gecko, Safari/419.3) Arora/0.3 (Change: 287 c9dfb30)",  
    "Mozilla/5.0 (X11; U; Linux; en-US) AppleWebKit/527+ (KHTML, like Gecko, Safari/419.3) Arora/0.6",  
    "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.2pre) Gecko/20070215 K-Ninja/2.1.1",  
    "Mozilla/5.0 (Windows; U; Windows NT 5.1; zh-CN; rv:1.9) Gecko/20080705 Firefox/3.0 Kapiko/3.0",  
    "Mozilla/5.0 (X11; Linux i686; U;) Gecko/20070322 Kazehakase/0.4.5",  
    "Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.8) Gecko Fedora/1.9.0.8-1.fc10 Kazehakase/0.5.6",  
    "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.56 Safari/535.11",  
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_3) AppleWebKit/535.20 (KHTML, like Gecko) Chrome/19.0.1036.7 Safari/535.20",  
    "Opera/9.80 (Macintosh; Intel Mac OS X 10.6.8; U; fr) Presto/2.9.168 Version/11.52",  
] 
```
## b)：添加代理IP设置PROXIES
```
PROXIES = [  
    {'ip_port': '111.11.228.75:80', 'user_pass': ''},  
    {'ip_port': '120.198.243.22:80', 'user_pass': ''},  
    {'ip_port': '111.8.60.9:8123', 'user_pass': ''},  
    {'ip_port': '101.71.27.120:80', 'user_pass': ''},  
    {'ip_port': '122.96.59.104:80', 'user_pass': ''},  
    {'ip_port': '122.224.249.122:8088', 'user_pass': ''},  
] 
```
## c)：禁用cookies
```
COOKIES_ENABLED=False
```

## d)：设置下载延迟
```
DOWNLOAD_DELAY=3
```

## e)：最后设置DOWNLOADER_MIDDLEWARES 
```
DOWNLOADER_MIDDLEWARES = {  
   #'cnblogs.middlewares.MyCustomDownloaderMiddleware': 543,  
    'cnblogs.middlewares.RandomUserAgent': 1,  
    'scrapy.contrib.downloadermiddleware.httpproxy.HttpProxyMiddleware': 110,  
   #'scrapy.downloadermiddlewares.httpproxy.HttpProxyMiddleware': 110,  
    'cnblogs.middlewares.ProxyMiddleware': 100,  
}
```

可以将这几步加到爬虫中测Q试一下.
其实还可以借助第三方平台来进行屏蔽,比如说crawlera,它十一哥利用代理ip地址池来做分布式下载的第三方平台,出了scrapy可以用之外,
普通的Java\PHP\Python都可以通过curl的方式来进行调用.
crawlera官方网址：http://scrapinghub.com/crawlera/
crawlera帮助文档：http://doc.scrapinghub.com/crawlera.html
