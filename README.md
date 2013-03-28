# Cache Control
It is designed for one of my project, in that project, we want reduce request number, but when server side update resource, client side should also update. So, I think we should try to cache resource, and also have the ability to update cache if we need, Cache Control is started based on this.

Cache Control is based on NSURLCache, support both native and web view cache., but it provides more features than NSURLCache. For example: update cache based on specific list

## Features
1.  Has all features NSURLCache has. Both has an in-memory and an on-disk cache. And also cache UIWebview request
2. Dynamic update cache
3.  Provide an  easy use api to get data from server
4.  Provide an easy use api to initial UIImageView with remote URL

## Overview
<p align="center">
  <img src="Class Relationship.png" alt="Cache Control Architecture Diagram"/>
</p>
Cache Control is architected to be as modular as possible, I hope it is simple to use and extend.
<table>
	<tr>
		<th colspan='2' >Core</th>
	</tr>
	<tr>
		<td> __SKURLCache__ </td>
		<td>SKURLCache is extended from NSURLCache. It provide in-memory and in-disk cache, also it will judge whether need to cache  response. We didn't cache response that url contains __KFINISHEDUPDATECACHENOTIFICATION__ </td>
	</tr>
	<tr>
		<td> __SKURLCacheUpdate__ </td>
		<td>SKURLCacheUpdate is responsible for update cache. You can use it to get update list from server then update cache, you also can start a NSTimer, let it update cache interval. If it updates a url successful, it will post a notification. When it update whole list, it will post a __KFINISHEDUPDATECACHENOTIFICATION__ notification</td>
	</tr>
	<tr>
		<th colspan='2' >HTTP Request</th>
	</tr>
	<tr>
		<td> __SKURLConnection__ </td>
		<td> __SKURLConnection__ that implements the NSURLConnection delegate method. You can use it to get data from server.</td>
	</tr>
	<tr>
		<th colspan='2' >Images</th>
	</tr>
	<tr>
		<td> __UIImageView+Cache__ </td>
		<td> __UIImageView+Cache__ extend UIImageView, add methods for loading image from server or from local cache. </td>
	</tr>
	<tr>
		<th colspan='2' >UIWebView</th>
	</tr>
	<tr>
		<td> __UIWebView__ </td>
		<td> Provide a javascript file for implement cache control for the resource in UIWebView. </td>
	</tr>
</table>

## Folder Structure
```
CacheControl
    |-- Docs
    |__ Sources
        |-- Client
            |__ iOS
                |__ CacheControl
        |__ Server
```

## Requirements
1. Know how to install Apache Server
2. Know how to change Apache Server configuration
3. Can understand HTML, JS, PHP and Obj-C

## Resources
1. [ XAMPP ](http://www.apachefriends.org/en/xampp.html): XAMPP is an easy to install Apache distribution containing MySQL, PHP and Perl
2. [ CodeIgniter Rest Server ](https://github.com/philsturgeon/codeigniter-restserver): A fully RESTful server implementation for CodeIgniter using one library, one config file and one controller
3. Following articles are helpful to understand Cache-Control
    > * [ http://www.mnot.net/cache_docs/ ](http://www.mnot.net/cache_docs/)
    > * [ http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.9](http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.9)
    > * [ http://www.websiteoptimization.com/speed/tweak/cache/ ](http://www.websiteoptimization.com/speed/tweak/cache/)
    > * [ https://devcenter.heroku.com/articles/ios-network-caching-http-headers ](https://devcenter.heroku.com/articles/ios-network-caching-http-headers)

## Contact
This application is developed by Shaoke Xu. You can use following way to contact me:

**Website**: <http://shaoke.me>

**Email**: [ blithexu@gmail.com ](blithexu@gmail.com)

## License
**Cache Control** is available under the MIT license. See the LICENSE file for more info.

