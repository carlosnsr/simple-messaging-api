# Simple Messaging API

This is a very simple messaging API.
It enables the building of a very simple messenger application.

Currently, it does not provide the creation of users.

## Operations

It allows these operations centered around `Messages`
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
**POST**&nbsp;&nbsp;`/api/v1/messages?recipient_id=2&sender_id=1&text=High life tumblr VHS Brooklyn iPhone helvetica fixie.`

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
                "timestamp": "2020-05-15T21:06:20.876Z"
              }
            }

+ Request returns an error, if recipient_id is missing
**POST**&nbsp;&nbsp;`/api/v1/messages?sender_id=1&text=Party aesthetic PBR letterpress trust fund craft beer lo-fi mixtape you probably haven't heard of them.`

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
**POST**&nbsp;&nbsp;`/api/v1/messages?recipient_id=2&text=Portland gentrify VHS photo booth leggings.`

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
                  "text": "Irony mlkshk art aesthetic fap messenger bag twee viral.",
                  "timestamp": "2020-05-15T21:06:20.910Z"
                },
                {
                  "sender_id": 3,
                  "recipient_id": 1,
                  "text": "Put a bird on it lomo blog gentrify squid.",
                  "timestamp": "2020-05-14T21:06:20.931Z"
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
                  "text": "Aesthetic seitan lomo gluten-free echo park banh mi viral fixie.",
                  "timestamp": "2020-05-15T21:06:20.949Z"
                },
                {
                  "sender_id": 3,
                  "recipient_id": 1,
                  "text": "Seitan beard helvetica art master cleanse squid.",
                  "timestamp": "2020-05-14T21:06:20.951Z"
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
                  "text": "Etsy irony keytar butcher Wes Anderson echo park master cleanse trust fund.",
                  "timestamp": "2020-05-15T21:06:20.981Z"
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
                  "text": "Messenger bag helvetica cliche Portland you probably haven't heard of them.",
                  "timestamp": "2020-05-15T21:06:21.002Z"
                }
              ]
            }
