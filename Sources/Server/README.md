# UXApp Server
This is server side code for UXApp Server. This server is based on "[CodeIgniter Rest Server]: https://github.com/philsturgeon/codeigniter-restserver".

# How to install

1. Download source code
2. Unpack source code, and put them to a PHP server
3. Modify "application/config/config.php". Change `$config['base_url']    = 'http://localhost/uxapp';` to correct url


# RESTful API v0.1 Resources

## user
User is required to login

### user/login

#### Description

Pass username and password to login uxapp. If it login successful, it will return authenticationkey and userid, when you call other uxapp API, if it needs 'Authentication', you need to pass authenticationkey.

#### URL

http://localhost/uxapp/user/login

#### Formats

JSON/XML

#### Request Method

*POST*

#### Request Parameters

*user_name*

1. Required: true
2. Type: string
3. Description: The user name of user

*password*

1. Required: true
2. Type: string
3. Description: The password of user

#### Response Parameters

*authentication_key*

1. Type: string
2. Description: This key is used to verify whether user can call uxapp API

*id*

1. Type: string
2. Description: Currently user's id

*menus*

1. Type: string
2. Description: this is an array contains all menuid that this user can access
3. Available Value
> * 0: notifications
> * 1: ux
> * 2: teammates
> * 3: products
> * 4: author

#### Example

_Request_

`curl  -X POST -d "user_name=test&password=12345" http://localhost/uxapp/index.php/api/user/login`

_Response_

* *Correct Response*
```
{
    "authentication_key":"sfafskkk23288233&&&&232323",
    "id":"1",
    "menus":[
        "0",
        "1",
        "2",
        "3",
        "4"
    ]
}
```

* *Wrong Response*
```
{
   "code": 1002,
   "msg": "Username do not exist"
}
```

#### Status
*Finished*

#### Error Code

About wrong return and error code, please see it in [Error Code](# 'Error Code Link')

#### Debug Link

[API Debug Link](# 'Error Code Link')

#### Note

N/A


## notifications

### notifications/all

#### Description

You can use this to get all notifications or get notification detail.

#### URL

http://localhost/uxapp/notifications/all

#### Formats

JSON/XML

#### Request Method

*GET*

#### Request Parameters

*last_time_stamp*

1. Required: false
2. Type: number
3. Description: The last update time stamp. If ** *last_time_stamp* ** isn't passed, so it will get all notifications, otherwise it just return the notification from ** *last_time_stamp* **

*number*

1. Required: false
2. Type: number
3. Description: How many latest notification you want to get.

If didn't pass ** *last_time_stamp* ** or ** *number* **, will return all notifications. If both pass ** *last_time_stamp* ** and ** *number* **, get ** *number* ** (less or equal) notifications from ** *last_time_stamp* **

#### Response Parameters

Return an array contains notification's summary information. Each notification summary inclue following field:

*id*

1. Type: string
2. Description: The id of this notifications. You can use this id to get more information about this notification

*title*

1. Type: string
2. Description: The title of this notification

*timestamp*

1. Type: number
2. Description: The timestamp of published time

*author*

1. Type: string
2. Description: Who publish this notification

#### Example

_Request_

``

_Response_

* *Correct Response*
```
{
    [
		{
			"title": "Tomorrow we need to have weekly meeting",
			"timestamp":12323232,
			"author":Tom,
			"id":1
		},
		{
			"title": "Tomorrow we need to have weekly meeting",
			"timestamp":12323232,
			"author":Tom,
			"id":1
		},
		{
			"title": "Tomorrow we need to have weekly meeting",
			"timestamp":12323232,
			"author":Tom,
			"id":1
		}
	]
}
```

* *Wrong Response*
```
{
   "code": 1001,
   "msg": "server is busy"
}
```

#### Status
*Finished*

#### Error Code

About wrong return and error code, please see it in [Error Code](# 'Error Code Link')

#### Debug Link

[API Debug Link](# 'Error Code Link')

#### Note

N/A

### notifications/get_notification_detail

#### Description

Get notification detail by notification id

#### URL

http://localhost/uxapp/notifications/get_notification_detail

#### Formats

JSON/XML

#### Request Method

*GET*

#### Request Parameters

*id*

1. Required: true
2. Type: number
3. Description: The id of queried notification

#### Response Parameters

*id*

1. Type: string
2. Description: The id of this notifications

*title*

1. Type: string
2. Description: The title of this notification

*timestamp*

1. Type: number
2. Description: The timestamp of published time

*author*

1. Type: string
2. Description: Who publish this notification

*detail*

1. Type: string
2. Description: The detail of queried notification

#### Example

_Request_

``

_Response_

* *Correct Response*
```
{
    [
		{
			"title": "Tomorrow we need to have weekly meeting",
			"timestamp":12323232,
			"author":Tom,
			"id":1,
			"detail":"Tomorrow we need to have weekly meeting"
		}
	]
}
```

* *Wrong Response*
```
{
   "code": 1001,
   "msg": "server is busy"
}
```

#### Status
*Finished*

#### Error Code

About wrong return and error code, please see it in [Error Code](# 'Error Code Link')

#### Debug Link

[API Debug Link](# 'Error Code Link')

#### Note

N/A

## ux

### ux/introduction

#### Description

Get ux team's introduction

#### URL

http://localhost/uxapp/ux/introduction

#### Formats

JSON/XML

#### Request Method

*GET*

#### Request Parameters

Empty

#### Response Parameters



#### Example

_Request_

``

_Response_

* *Correct Response*
```
{
    [
		{
			"title": "Tomorrow we need to have weekly meeting",
			"timestamp":12323232,
			"author":Tom,
			"id":1,
			"detail":"Tomorrow we need to have weekly meeting"
		}
	]
}
```

* *Wrong Response*
```
{
   "code": 1001,
   "msg": "server is busy"
}
```

#### Status
*Finished*

#### Error Code

About wrong return and error code, please see it in [Error Code](# 'Error Code Link')

#### Debug Link

[API Debug Link](# 'Error Code Link')

#### Note

N/A