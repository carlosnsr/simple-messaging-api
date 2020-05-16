# Simple Messaging API

This is a very simple messaging API.
It enables the building of a very simple messenger application.

## Operations

It allows these operations:
- creating users
- getting a list of all existing users
- sending a short message between 2 existing users (a sender, and a recipient)
- getting a recipient's most recent messages (in last 30 days, up to 100) from any sender
- getting a recipient's most recent messages (in last 30 days, up to 100) from a particular sender

# Group Messages


## Messages [/messages]


### Send a message [POST /api/v1/messages]
Saves a short text message, from a sender to a recipient.
This message will show up in that recipient's recent messages.

+ Parameters
    + message.recipient_id: `123` (number, required)
    + message.sender_id: `456` (number, required)
    + message.text: `Hello` (text, required)

+ Request returns the message id and timestamp
**POST**&nbsp;&nbsp;`/api/v1/messages?message[recipient_id]=2&message[sender_id]=1&message[text]=Thundercats beard Shoreditch Austin cardigan hoodie tattooed PBR.`

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
                "timestamp": "2020-05-16T03:08:19.439Z"
              }
            }

+ Request returns an error, if recipient_id is missing
**POST**&nbsp;&nbsp;`/api/v1/messages?message[sender_id]=1&message[text]=Fixie biodiesel Four Loko cred whatever freegan scenester Brooklyn vinyl.`

    + Headers

            Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5
            Content-Type: application/x-www-form-urlencoded

+ Response 422

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "errors": [
                "Recipient must exist",
                "Recipient can't be blank"
              ]
            }

+ Request returns an error, if sender_id is missing
**POST**&nbsp;&nbsp;`/api/v1/messages?message[recipient_id]=2&message[text]=Brunch Carles yr tattooed salvia mustache fixie 8-bit wolf.`

    + Headers

            Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5
            Content-Type: application/x-www-form-urlencoded

+ Response 422

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "errors": [
                "Sender must exist",
                "Sender can't be blank"
              ]
            }

+ Request returns an error, if text is missing
**POST**&nbsp;&nbsp;`/api/v1/messages?message[recipient_id]=2&message[sender_id]=1`

    + Headers

            Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5
            Content-Type: application/x-www-form-urlencoded

+ Response 422

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "errors": [
                "Text can't be blank"
              ]
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
                  "text": "Lomo keytar Austin yr chambray raw denim blog viral.",
                  "timestamp": "2020-05-16T03:08:19.482Z"
                },
                {
                  "sender_id": 3,
                  "recipient_id": 1,
                  "text": "Master cleanse tofu biodiesel Banksy skateboard DIY gentrify.",
                  "timestamp": "2020-05-15T03:08:19.484Z"
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
                  "text": "Portland Banksy fixie vice mixtape VHS Marfa lomo organic.",
                  "timestamp": "2020-05-16T03:08:19.504Z"
                },
                {
                  "sender_id": 3,
                  "recipient_id": 1,
                  "text": "Cred before they sold out viral Four Loko Carles lo-fi squid freegan.",
                  "timestamp": "2020-05-15T03:08:19.506Z"
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
                  "text": "Pbr cred fanny pack whatever Wes Anderson chambray cliche moon biodiesel.",
                  "timestamp": "2020-05-16T03:08:19.551Z"
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
                  "text": "Twee DIY Four Loko fanny pack Carles mlkshk vice.",
                  "timestamp": "2020-05-16T03:08:19.572Z"
                }
              ]
            }

# Group Users


## Users [/users]


### Create a user [POST /api/v1/users]
Provided with a name, creates a user with that name.

Returns the user's ID

+ Parameters
    + user.name: `Margeret+Fritsch` (string, required)

+ Request returns the new user's id
**POST**&nbsp;&nbsp;`/api/v1/users?user[name]=Armida Lehner`

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
                "Name can't be blank"
              ]
            }

### Get users [GET /api/v1/users]
Returns a list of all the users currently in the system


+ Request returns a list of users
**GET**&nbsp;&nbsp;`/api/v1/users`

    + Headers

            Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "users": [
                {
                  "id": 1,
                  "name": "Cecily Weber"
                },
                {
                  "id": 2,
                  "name": "Dianne Goldner"
                }
              ]
            }
