#### About
Rest API for personal conversation between one person and another

#### Database Design
![image](https://github.com/choniyuazwan/chat-api/blob/master/public/database-design.png?raw=true)

#### 1. register
```
post: chat-api-ruby.herokuapp.com/register
```
##### request body
```
{
    "username": "dora",
    "password": "aaaaaa",
    "fullname": "dora emon"
} 
```

#### 2. login
```
post: chat-api-ruby.herokuapp.com/login
```
##### request body
```
{
    "username": "dora",
    "password": "aaaaaa"
} 
```

#### 3. list conversation
```
get: chat-api-ruby.herokuapp.com/conversations
```
##### request header
`Authorization: Bearer {token}`

#### 4. list message
```
get: chat-api-ruby.herokuapp.com/messages/:id_recipient
```
##### request header
`Authorization: Bearer {token}`

#### 5. create message
```
post: chat-api-ruby.herokuapp.com/messages
```
##### request body
```
{
	"recipient_id": 2,
	"content": "dari dora"
} 
```
##### request header
`Authorization: Bearer {token}`