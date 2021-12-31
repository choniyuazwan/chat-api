#### About
Rest API for personal conversation between one person and another

#### Database Design
![image](https://github.com/choniyuazwan/chat-api/blob/master/public/database-design.png?raw=true)

##### Existing account ready to use
```
{"username": "budi", "password": "aaaaaa"}
{"username": "tono", "password": "aaaaaa"}
{"username": "andi", "password": "aaaaaa"}
{"username": "dodo", "password": "aaaaaa"}
{"username": "anto", "password": "aaaaaa"}
{"username": "sari", "password": "aaaaaa"}
```
Base address: https://chat-api-ruby.herokuapp.com

#### 1. register
```
post: https://chat-api-ruby.herokuapp.com/register
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
post: https://chat-api-ruby.herokuapp.com/login
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
get: https://chat-api-ruby.herokuapp.com/conversations
```
##### request header
```
Authorization: Bearer {token}
```

#### 4. list message
```
get: https://chat-api-ruby.herokuapp.com/messages/:id_recipient
```
##### request header
```
Authorization: Bearer {token}
```

#### 5. create message
```
post: https://chat-api-ruby.herokuapp.com/messages
```
##### request body
```
{
    "recipient_id": 2,
    "content": "dari dora"
} 
```
##### request header
```
Authorization: Bearer {token}
```

#### Example Response Body
##### Register and Login
```
{
    "code": 201,
    "message": "success",
    "data": {
        "id": 1,
        "username": "dora",
        "token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE2NDEwMjE4MDZ9.lSIYtzgG5mvnXv6X4AP7pCchnsiZ6DKwTZqcssWBcM4",
        "fullname": "dora emon"
    },
    "current_page": null,
    "per_page": null,
    "total_page": null,
    "total_count": null
}
```
##### List Conversation
```
{
    "code": 200,
    "message": "success",
    "data": [
        {
            "id": 3,
            "recipient": "andi malarangeng",
            "last_message": "dari andi",
            "last_message_type": "incoming",
            "is_read": false,
            "total_unread": 2,
            "created_at": "2021-12-31T09:11:06.886Z"
        },
        {
            "id": 1,
            "recipient": "tono sucipto",
            "last_message": "dari budi",
            "last_message_type": "outgoing",
            "is_read": true,
            "total_unread": 0,
            "created_at": "2021-12-31T09:10:15.618Z"
        }
    ],
    "current_page": 1,
    "per_page": 10,
    "total_page": 1,
    "total_count": 2
}
```
##### List Message
```
{
    "code": 200,
    "message": "success",
    "data": [
        {
            "id": 4,
            "content": "dari andi",
            "type": "incoming",
            "is_read": true,
            "created_at": "2021-12-31T09:11:06.886Z"
        },
        {
            "id": 3,
            "content": "dari budi",
            "type": "outgoing",
            "is_read": false,
            "created_at": "2021-12-31T09:10:18.268Z"
        }
    ],
    "current_page": 1,
    "per_page": 10,
    "total_page": 1,
    "total_count": 2
}
```