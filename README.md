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
  <img src="./Docs/images/Class Relationship.png" alt="Cache Control Architecture Diagram"/>
</p>
Cache Control is architected to be as modular as possible, I hope it is simple to use and extend.
<table>
	<tr>
		<th colspan='2' >Core</th>
	</tr>
	<tr>
		<td> <strong>SKURLCache</strong></td>
		<td>SKURLCache is extended from <a href="https://developer.apple.com/library/ios/#documentation/Cocoa/Reference/Foundation/Classes/NSURLCache_Class/Reference/Reference.html" title="NSURLCache">NSURLCache</a>. It provide in-memory and in-disk cache, also it will judge whether need to cache  response. We didn't cache response that url contains <span style="color:rgb(155, 77, 28);font-weight:bold;">SKFORCEUSECACHEFILEINDENTIFICATION</span> </td>
	</tr>
	<tr>
		<td> <strong>SKURLCacheUpdate</strong> </td>
		<td>SKURLCacheUpdate is responsible for update cache. You can use it to get update list from server then update cache, you also can start a NSTimer, let it update cache interval. If it updates a url successful, it will post a notification. When it update whole list, it will post a <span style="color:rgb(155, 77, 28);font-weight:bold;">SKFINISHEDUPDATECACHENOTIFICATION</span> notification</td>
	</tr>
	<tr>
		<th colspan='2' >HTTP Request</th>
	</tr>
	<tr>
		<td> <strong>SKURLConnection</strong> </td>
		<td> <strong>SKURLConnection</strong> that implements the <a title="NSURLConnection" href="https://developer.apple.com/library/ios/#documentation/Cocoa/Conceptual/URLLoadingSystem/Tasks/UsingNSURLConnection.html#//apple_ref/doc/uid/20001836-BAJEAIEE">NSURLConnection</a> delegate method. You can use it to get data from server.</td>
	</tr>
	<tr>
		<th colspan='2' >Images</th>
	</tr>
	<tr>
		<td> <strong>UIImageView+Cache</strong> </td>
		<td> <strong>UIImageView+Cache</strong> extend UIImageView, add methods for loading image from server or from local cache. </td>
	</tr>
	<tr>
		<th colspan='2' >UIWebView</th>
	</tr>
	<tr>
		<td> <strong>UIWebView</strong> </td>
		<td> Provide a javascript file for implement cache control for the resource in UIWebView. </td>
	</tr>
</table>

## Work Flow
<p align="center">
  <img src="./Docs/images/Work Flow.png" alt="Cache Control Architecture Diagram"/>
</p>
Let me explain what is the work flow when you use **Cache Control**.

* **Step 1**: Use SKURLConnection to get data. (Actually, UIWebview will use NSURLConnection to get data, for easy, we both said it use SKURLConnection)

* **Step 2**: Before it really send request to server, it will check whether it has cache (__Assume you use default cache policy__)
> <p style="background-color:yellow;"><span style="color: red; font-weight:bold;">Note:</span> This behaviour is controlled by NSURLCache Cache Policy. You can get more information about Cache Policy from <a title="Understanding Cache Access" href="https://developer.apple.com/library/ios/#documentation/Cocoa/Conceptual/URLLoadingSystem/Concepts/CachePolicies.html#//apple_ref/doc/uid/20001843-BAJEAIEE">Understanding Cache Access</a></p>

* **Step 3**: If it has cached before, it will return the value cached in SKURLCache

* **Step 4**: Otherwise, it will send request to server to get data

* **Step 5**: Server return data

* **Step 6**: The data return by server will also cached in SKURLCache

* **Step 7**: SKURLCacheUpdate get update list from server

* **Step 8**: Based on the list get from server, start update cache.

* **Step 9**, **Step 10**: When update url success or fail, post a notification

* When UIImageView and UIWebView receive this notification, will start update.


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
Following articles I read it when I think about cache

1. [ XAMPP ](http://www.apachefriends.org/en/xampp.html): XAMPP is an easy to install Apache distribution containing MySQL, PHP and Perl
2. [ CodeIgniter Rest Server ](https://github.com/philsturgeon/codeigniter-restserver): A fully RESTful server implementation for CodeIgniter using one library, one config file and one controller
3. Following articles are helpful to understand Cache-Control

    > * [ http://www.mnot.net/cache_docs/ ](http://www.mnot.net/cache_docs/)
    > * [ http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.9](http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.9)
    > * [ http://www.websiteoptimization.com/speed/tweak/cache/ ](http://www.websiteoptimization.com/speed/tweak/cache/)
    > * [ https://devcenter.heroku.com/articles/ios-network-caching-http-headers ](https://devcenter.heroku.com/articles/ios-network-caching-http-headers)

Following third part libraries I just used in develop time, the purpose is for debug, generate doc…

  1. [PonyDebugger](https://github.com/square/PonyDebugger): Remote debugging toolset, to see request detail
  2. [Appledoc](https://github.com/tomaz/appledoc): Generate Apple-like document

## Contact
This application is developed by Shaoke Xu. You can use following way to contact me:

**Website**: <http://shaoke.me>

**Email**: [ shaokexu@gmail.com ](shaokexu@gmail.com)

## License
**Cache Control** is available under the MIT license. See the LICENSE file for more info.

