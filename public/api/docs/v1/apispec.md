# Simple Messaging API

This is a very simple messaging API.
It enables the building of a very simple messenger application.

## Operations

It allows these operations:
- creating users
- sending a short message between 2 existing users (a sender, and a recipient)
- getting a recipient's most recent messages (in last 30 days, up to 100) from any sender
- getting a recipient's most recent messages (in last 30 days, up to 100) from a particular sender

# Group Messages


## Messages [/messages]


### Send a message [POST /api/v1/messages]
Saves a short text message, from a sender to a recipient.
This message will show up in that recipient's recent messages.

+ Parameters
    + recipient_id: `123` (number, required)
    + sender_id: `456` (number, required)
    + text: `Hello` (text, required)

+ Request returns the message id and timestamp
**POST**&nbsp;&nbsp;`/api/v1/messages?recipient_id=2&sender_id=1&text=Stumptown Williamsburg banh mi VHS craft beer mixtape.`

    + Headers

            Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5
            Content-Type: application/x-www-form-urlencoded

+ Response 201

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "message": {
                "id": 1,
                "timestamp": "2020-05-16T02:13:05.386Z"
              }
            }

+ Request returns an error, if recipient_id is missing
**POST**&nbsp;&nbsp;`/api/v1/messages?sender_id=1&text=Blog Marfa messenger bag letterpress whatever Wes Anderson Shoreditch brunch.`

    + Headers

            Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5
            Content-Type: application/x-www-form-urlencoded

+ Response 422

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "error": "param is missing or the value is empty: recipient_id"
            }

+ Request returns an error, if sender_id is missing
**POST**&nbsp;&nbsp;`/api/v1/messages?recipient_id=2&text=Food truck locavore master cleanse hoodie lo-fi biodiesel.`

    + Headers

            Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5
            Content-Type: application/x-www-form-urlencoded

+ Response 422

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "error": "param is missing or the value is empty: sender_id"
            }

+ Request returns an error, if text is missing
**POST**&nbsp;&nbsp;`/api/v1/messages?recipient_id=2&sender_id=1`

    + Headers

            Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5
            Content-Type: application/x-www-form-urlencoded

+ Response 422

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "error": "param is missing or the value is empty: text"
            }

### Get recent messages [GET /api/v1/messages?recipient_id={recipient_id}]
Provided a recipient's ID, gets messages that were sent to that recipient.

Gets the first 100 most recent messages,
no older than 30 days, and ordered most-recent-first.

+ Parameters
    + recipient_id: `123` (number, required)

+ Request returns the message
**GET**&nbsp;&nbsp;`/api/v1/messages?recipient_id=1`

    + Headers

            Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "messages": [
                {
                  "sender_id": 2,
                  "recipient_id": 1,
                  "text": "Wes anderson trust fund iPhone beard Wayfarers before they sold out +1 retro.",
                  "timestamp": "2020-05-16T02:13:05.443Z"
                },
                {
                  "sender_id": 3,
                  "recipient_id": 1,
                  "text": "Cardigan you probably haven't heard of them messenger bag butcher skateboard keffiyeh 8-bit.",
                  "timestamp": "2020-05-15T02:13:05.445Z"
                }
              ]
            }

+ Request returns an error if the recipient does not exist
**GET**&nbsp;&nbsp;`/api/v1/messages?recipient_id=1234`

    + Headers

            Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5

+ Response 422

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "error": "recipient 1234 does not exist"
            }

### Get recent messages (alternative) [GET /api/v1/recipents/{recipient_id}/messages]
An alternative way to get a recipient's messages.
Same behavior and results as `/api/v1/messages?recipient_id={recipient_id}`.

+ Parameters
    + recipient_id: `123` (number, required)

+ Request returns the message
**GET**&nbsp;&nbsp;`/api/v1/recipients/1/messages`

    + Headers

            Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "messages": [
                {
                  "sender_id": 2,
                  "recipient_id": 1,
                  "text": "Retro cliche messenger bag mixtape put a bird on it chambray farm-to-table Austin vice.",
                  "timestamp": "2020-05-16T02:13:05.465Z"
                },
                {
                  "sender_id": 3,
                  "recipient_id": 1,
                  "text": "Vice tattooed viral farm-to-table high life.",
                  "timestamp": "2020-05-15T02:13:05.468Z"
                }
              ]
            }

+ Request returns an error if the recipient does not exist
**GET**&nbsp;&nbsp;`/api/v1/recipients/1234/messages`

    + Headers

            Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5

+ Response 422

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "error": "recipient 1234 does not exist"
            }

### Get recent messages from sender [GET /api/v1/messages?recipient_id={recipient_id}&sender_id={sender_id}]
Provided a recipient's ID and a sender's ID,
gets messages that were sent to that recipient.
by that sender.

Gets the first 100 most recent messages,
no older than 30 days, and ordered most-recent-first.

+ Parameters
    + recipient_id: `123` (number, required)
    + sender_id: `456` (number, required)

+ Request returns empty array of messages if no messages from that sender
**GET**&nbsp;&nbsp;`/api/v1/messages?recipient_id=1&sender_id=3`

    + Headers

            Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "messages": [
            
              ]
            }

+ Request returns all messages from that sender
**GET**&nbsp;&nbsp;`/api/v1/messages?recipient_id=1&sender_id=2`

    + Headers

            Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "messages": [
                {
                  "sender_id": 2,
                  "recipient_id": 1,
                  "text": "Food truck stumptown master cleanse quinoa leggings.",
                  "timestamp": "2020-05-16T02:13:05.497Z"
                }
              ]
            }

### Get recent messages from sender (alternative) [GET /api/v1/recipents/{recipient_id}/sender/{sender_id}/messages]
An alternative way to get a recipient's messages from a particular user.
Same behavior and results as `/api/v1/messages?recipient_id={recipient_id}&sender_id={sender_id}`.

+ Parameters
    + recipient_id: `123` (number, required)
    + sender_id: `456` (number, required)

+ Request returns empty array of messages if no messages from that sender
**GET**&nbsp;&nbsp;`/api/v1/recipients/1/senders/3/messages`

    + Headers

            Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "messages": [
            
              ]
            }

+ Request returns all messages from that sender
**GET**&nbsp;&nbsp;`/api/v1/recipients/1/senders/2/messages`

    + Headers

            Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "messages": [
                {
                  "sender_id": 2,
                  "recipient_id": 1,
                  "text": "Craft beer tofu PBR keffiyeh banh mi twee skateboard ethical.",
                  "timestamp": "2020-05-16T02:13:05.520Z"
                }
              ]
            }

# Group Users


## Users [/users]


### Create a user [POST /api/v1/users]
Provided with a name, creates a user with that name.

Returns the user's ID


+ Request returns the new user's id
**POST**&nbsp;&nbsp;`/api/v1/users?user[name]=Ardell Christiansen`

    + Headers

            Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5
            Content-Type: application/x-www-form-urlencoded

+ Response 201

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "user": {
                "id": 1
              }
            }

+ Request returns an error, if name is missing
**POST**&nbsp;&nbsp;`/api/v1/users?user[not_name]=Ummm... Hi`

    + Headers

            Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5
            Content-Type: application/x-www-form-urlencoded

+ Response 422

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "errors": [
                {
                  "name": [
                    "can't be blank"
                  ]
                }
              ]
            }
